xml.instruct!

xml.urlset xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  xml.url do
    xml.loc canonical_url('/')
  end

  all_posts.each do |page|
    xml.url do
      xml.loc canonical_url(page.path)
      xml.lastmod parse_date(page.data.modified_on || page.data.published_on).to_time.iso8601
    end
  end
end
