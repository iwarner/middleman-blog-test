##
# Page options, layouts, aliases and proxies
##

##
# Better errors
##
require "better_errors"

##
# Live reload
# @see https://github.com/middleman/middleman-livereload
##
# activate :livereload, apply_js_live: false, apply_css_live: false

##
# Core Configuration
##

# config[ :asset_extensions ] = ''
config[ :css_dir ]          = 'assets/stylesheets'
config[ :js_dir ]           = 'assets/javascripts'
config[ :images_dir ]       = 'assets/images'
config[ :fonts_dir ]        = 'assets/fonts'
config[ :show_exceptions ]  = false
# config[ :build_dir ]        = "build"
# config[ :https ]            = false
# config[ :partials_dir ]     = 'partial/codeBlender'
# config[ :disable_sitemap ]  = false
# config[ :domain_name ]      = "http://localhost:4567"

# Relative links
# config[ :relative_links ] = true

##
# File watch
# Include codeblender atom partials into this
##
# files.watch :source,
#     path: File.expand_path("/var/www/DryKiss/codeblender.io/public/source/atom"),
#     destination_dir: "partial/codeBlender"

# files.watch :source, path: File.expand_path( '/var/www/DryKiss/codeblender.io/public/source/atom' ), destination_dir: 'source2/'
# files.watch :source, path: File.join( root, '/var/www/DryKiss/codeblender.io/public/source/atom' ), destination_dir: 'source/source2'

# files.watch :source,
#     path: File.expand_path( "/var/www/DryKiss/codeblender.io/public/source/atom" ),
#     destination_dir: "partial/_codeBlender",
#     frontmatter: false,
#     binary: false

# import_path "/Users/rubytastic/shared/assets"

##
# Ready do used for creating new dynamic pages
##
# ready do
# end

##
# Internationalisation
##
mount   = :"en-gb"
locales = [ :"en-gb", :"fr-be" ]

# I18n
# @see https://middlemanapp.com/advanced/localization/
# @see http://www.rubydoc.info/github/svenfuchs/i18n/I18n
activate :i18n do | i |
  i.locales       = locales
  i.mount_at_root = mount
  # i.path          = "/:locale/"
  # i.lang_map      = { :'en-gb' => 'en-gb', :'fr-be' => 'fr-be' }
end

##
# Blogs : Loop through the locales
##
locales.each_with_index do | locale, index |

  # Blog
  activate :blog do | blog |

    # Debug
    # puts locale, index

    # Locale path
    path = index > 0 ? "#{ locale }/" : ""

    blog.name      = "blog_#{ locale.to_s }"
    blog.permalink = "#{ path }{title}.html"

    # blog.sources   = "/blogLocaleFolders/#{ locale }/:id.html"
    blog.sources   = "/blogLocaleFolders/#{ locale }/{title}.html"
    # blog.sources   = "/blogLocaleFolders/#{ locale }/{permalink}.html"

    blog.layout    = "blog"

    # Pagination
    blog.paginate  = true
    blog.page_link = "page{num}"
    blog.per_page  = 3

    # Calendar
    blog.calendar_template = "template/calendar.html"
    blog.year_link         = "#{ path }archive/:year.html"
    blog.month_link        = "#{ path }archive/:year/:month.html"
    blog.day_link          = "#{ path }archive/:year/:month/:day.html"

    # Filter
    blog.filter = proc { |article| !article.title.start_with?('Tester 2') }

    # Seprator
    blog.summary_separator = "==="

    # Tags
    blog.tag_template = "template/tag.html"
    blog.taglink      = "#{ path }tag/{tag}.html"

    # Custom collections
    blog.custom_collections = {

      # Category
      category: {
        link:     "#{ path }{category}.html",
        template: "template/category.html"
      },

      # Author
      author: {
        link:     "#{ path }{author}.html",
        template: "template/author.html"
      }

    }

  end

  # blog.data no longer works
  # ready do

  #   blog.data.articles.each do | article |
  #     puts article
  #   end

  # end

  ##
  # Ready hook
  # Add options to international template pages - needs to push locale into these
  # See the Sitemap __middleman for this
  ##
  ready do

    # Get all the french tags
    sitemap.resources.select{ | d | d.data.template }.each do | resource |

      if resource.path[ 0...5 ] === locale.to_s

        # puts "Process #{ resource.path }"

        resource.add_metadata options: {
          locale: locale,
          lang:   locale
        }

      end

    end

  end

end

# Build-specific configuration
configure :development do
  # Better errors Gem
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__

  # Ignore test file
  ignore "test.html"

  # Ignore test folder
  ignore "test/*"
  ignore "blog/*"

  # Ignore international file
  # Does not work
  ignore "localizable/international.html"

  # Ignore a all folders in a folder except one
  ignore /blogsIgnoreTest\/(?!test2)/
  ignore /blogsIgnoreTest/
  ignore /blogLocaleMatter/
end

# Build-specific configuration
configure :build do
  # "Ignore" JS and CSS so webpack has full control.
  # ignore { | path | path =~ /\/(.*)\.js|css$/ && $1 != "_body" && $1 != "_site" }

  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end

# ENV[ 'WEBPACK_ENV' ] ||= ( build? ? 'build' : 'development' )

##
# External pipeline - Webpack
##
# activate :external_pipeline do | i |
#   i.name                         = :webpack
#   i.command                      = build? ? './node_modules/webpack/bin/webpack.js --bail -p' : './node_modules/webpack/bin/webpack.js --watch'
#   i.source                       = ".tmp"
#   i.latency                      = 1
#   i.disable_background_execution = false
# end
