#########
# 
# Written following the example of cb_page_gen in CollectionBuilder, https://github.com/CollectionBuilder/collectionbuilder-csv
#
#########
module CollectionBuilderPageGenerator
  class ItemPageGenerator < Jekyll::Generator
    safe true
    include Jekyll::Utils

    def generate(site)
      csv_configs = {
        'posts' => site.config['posts_csv']
      }

      csv_configs.each do |name, data_file|
        next unless data_file
        generate_pages_from_csv(site, name, data_file)
      end
    end

    def generate_pages_from_csv(site, name, data_file)
      template_location = "#{name}/"
      template = "items/#{name}"
      display_template = 'display_template'
      filename_field = 'id'
      dir = name.sub(/s$/, '') # singularize output dir
      extension = 'html'
      filter = 'id'
      filter_condition = '!record["parentid"]'

      unless site.data.key?(data_file)
        puts color_text("Error: Data value '#{data_file}' not found in site.data.", :red)
        return
      end

      puts color_text("Building pages for '#{name}' from '#{data_file}' into '/#{dir}/'...", :green)

      records = site.data[data_file]
      records = records.select { |r| r[filter] } if filter
      records = records.select { |record| eval(filter_condition) } if filter_condition

      puts color_text("  Found #{records.size} records to process.", :green)

      names_test = records.map { |x| x[filename_field] }
      if names_test.size != names_test.uniq.size
        puts color_text("Error: Duplicate '#{filename_field}' values!", :red)
      end

      all_layouts = site.layouts.keys
      template_test = records.map { |x| x[display_template] ? template_location + x[display_template].strip : template }.uniq
      missing_layouts = (template_test - all_layouts)
      if !missing_layouts.empty?
        puts color_text("Warning: Missing layouts #{missing_layouts.join(', ')}", :yellow)
      end

      page_count = 0
      records.each_with_index do |record, index|
        next if record[filename_field].nil? || record[filename_field].strip.empty?
        record['base_filename'] = slugify(record[filename_field], mode: "pretty").to_s
        record['index_number'] = index
        next_item = records[(index + 1) % records.size][filename_field]
        previous_item = records[(index - 1) % records.size][filename_field]
        record['next_item'] = "/#{dir}/#{slugify(next_item, mode: "pretty")}.#{extension}"
        record['previous_item'] = "/#{dir}/#{slugify(previous_item, mode: "pretty")}.#{extension}"
        record['layout'] = record[display_template] ? template_location + record[display_template].strip : template
        record['layout'] = template unless all_layouts.include?(record['layout'])
        next unless all_layouts.include?(record['layout'])
        site.pages << ItemPage.new(site, record, dir, extension)
        puts color_text("    Generated: /#{dir}/#{record['base_filename']}.#{extension}", :green)
        page_count += 1
      end
      puts color_text("  Total pages generated for '#{name}': #{page_count}", :green)
    end

    def text_colors
      @colors = { red: 31, yellow: 33, green: 32 }
    end
    def color_text(str, color_code)
      "\e[#{text_colors[color_code]}m#{str}\e[0m"
    end
  end

  class ItemPage < Jekyll::Page
    def initialize(site, record, dir, extension)
      @site = site
      @base = site.source
      @dir  = dir
      @basename = record['base_filename']
      @ext      = ".#{extension}"
      @name     = "#{@basename}.#{extension}"
      @data     = record
    end
  end
end