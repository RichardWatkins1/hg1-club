# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

activate :blog do |blog|
  blog.name = "posts"
  blog.prefix = "posts"
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

activate :livereload

set :relative_links, true

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings
activate :gzip

configure :build do
  activate :minify_html
  activate :minify_css
  activate :minify_javascript
end

helpers do

  def canonical_url(append_path = current_page.path)
    path = append_path == "index.html" ? "" : append_path.sub(/^\//, "")
    "https://hg1.club/#{path}"
  end

  def all_posts
    sitemap.resources.select do |page|
      page.data.published_on &&  page.path.include?("posts") && page.path.include?("html")
    end.sort do |a,b|
      parse_date(a.data.modified_on || a.data.published_on) <=>
      parse_date(b.data.modified_on || b.data.published_on)
    end.reverse
  end

  def parse_date(date)
    date.respond_to?(:strftime) ? date : DateTime.parse(date)
  end
end
