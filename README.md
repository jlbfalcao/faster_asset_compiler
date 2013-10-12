# FasterAssetCompiler

A pure java yui and closure compressor, loading directly .jar files.

Current versions:
* yuicompressor: 2.4.8
* closure: v20130823

## Installation

Add this line to your application's Gemfile:

    gem 'faster_asset_compiler'

And add to production.rb

    config.assets.compress = true
    config.assets.js_compressor = :yui # or closure - is a little bit slower than yui
    config.assets.css_compressor = :yui

Restrictions:
* Don't use js_compressor = :yui and therubyrhino; don't work.

## TODO

* Add more customization to compressors

