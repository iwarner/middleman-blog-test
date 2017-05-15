# Todo list

Provide a low installation of Middleman for ease of testing new features or
ideas Should be super fast to load and test these, no aesthetic needed.

## Search

- http://willschenk.com/adding-search-to-a-middleman-blog/

## Setup

- [ ] Symlink in the Helpers here
- [ ] Print out ruby version
- [ ] Print out Middleman version
- [ ] Print out version of HAML
- [ ] Print out version of Coffee
- [ ] Print out version of Kramdown
- [ ] Ability to remove webpack easily - for faster reloads
- [ ] Get the HTTPs working

## YAML

- [ ] Embed ruby in data file - https://forum.middlemanapp.com/t/render-erb-from-data-file/2597

## Layout

- [ ]

## Glob

- [ ] bundle exec middleman build --glob="404.html" --no-clean

## Live reload

- [ ] Sort out what the options are for this - from middleman and what they do
      - apply_js_live: false, apply_css_live: false

## File watch

- [ ] File watch does not allow partials to be surfaced through the method
- [ ] What does the import_path do

## Relative links

- [ ] These fail on localisation link_to

## Internationalisation

Place core files in the Localizable folder

- [ ] https://github.com/middleman/middleman/issues/1110

## Blog

@see http://willschenk.com/middleman-tricks-and-hacks/
@see https://github.com/DefactoSoftware/website/pull/87
@see https://github.com/middleman/middleman/issues/1144
@see https://github.com/middleman/middleman-templates-blog/tree/master/template/source

The blog runs of a different locale to that of the core middleman

- [ ] Allow to change the blogname dynamically
- [ ] Test the lang tag or
-# Test for draft article
-# = current_post.is_a? ::Middleman::Blog::Drafts::DraftArticle

## Markdown

- [ ]

## Helpers

- [ ] Create a page to utilise the middleman helpers - like image_tag
