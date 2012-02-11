require "spec_helper"

require "massive_sitemap/builder/index"
require "massive_sitemap/writer/string"

describe MassiveSitemap::Builder::Index do
  INDEX_HEADER = %Q(<?xml version="1.0" encoding="UTF-8"?>\n<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n<sitemap>)

  let(:writer) { MassiveSitemap::Writer::String.new }

  it 'generates one url' do
    MassiveSitemap::Builder::Index.new(writer, :indent_by => 0) do
      add 'test'
    end
    writer.string.should == %Q(#{INDEX_HEADER}\n<loc>/test</loc>\n</sitemap>\n</sitemapindex>)
  end

  it 'include base_url' do
    MassiveSitemap::Builder::Index.new(writer, :base_url => "test.de", :indent_by => 0) do
      add 'test'
    end
    writer.string.should include("<loc>http://test.de/test</loc>")
  end

end