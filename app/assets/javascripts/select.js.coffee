#= require lib/module

class window.Select extends Module
  @of: (name, options = {}) ->
    options.bind ?= false

    new Select(name, options)

  defaults:
    formatSearching: ->
      "<span>#{I18n.t('question.tag.searching')}</span>"
    formatNoMatches: ->
      "<span>#{I18n.t('question.tag.no_matches_found')}</span>"
    tokenizer: (input, selection, callback, options) ->
      tokenizer = /,/

      if tokenizer.test(input)
        value = input.replace(tokenizer, '')

        return callback(id: value, text: value) if value.length > 0

      result = "#{input}".toLowerCase()
      result = result.replace(/[\s\,\;\`\!\@\#\$\%\^\&\*\(\)\_\+\-\=\[\]\'\\\.\/\{\}\:\"\|\<\>\?]+/gm, '-')
      result = result.replace(/^-/, '')
  roles:
    tags:
      tags: true
      multiple: true
      tokenSeparators: [' ', ',', ';']
      initSelection: (element, callback) ->
        values = $(element).val().split(',').map (e) -> { id: e, text: e }

        callback(values)
      formatSelection: (item) -> item.id
      createSearchChoice : (term, data) -> { id: term, text: "#{term} (#{I18n.t('question.tag.new')})" } if data.length == 0
      ajax:
        url: '/tags/suggest'
        dataType: 'json'
        data: (term, page) ->
          q: term
          page: page - 1
        results: (data, page) ->
          data
    filter:
      createSearchChoice: (term, data) -> return if data.length == 0

  constructor: (selector, options = {}) ->
    @selector = selector ?= '[data-as=select2]'

    @.bind() if options.bind ?= true

    @

  each: (callback) ->
    $(@selector).each (index, element) ->
      callback(index, element)

  bind: ->
    @.each (i, element) =>
      role    = $(element).attr('data-role')
      options = @.options_for role

      $(element).select2 options

      $(element).on 'change', -> $(this).select2('focus')

  on: (event, callback) ->
    $(@selector).on(event, callback)

  attr: (name) ->
    $(@selector).attr(name)

  addItem: (item) ->
    @addItem [item]

  addItems: (others) ->
    @.each (i, element) =>
      items = $(element).select2('data')

      for item in others
        item = { id: item, text: item } unless typeof(item) == 'object'

        items.push(item)

      $(element).select2('data', items)
      $(element).trigger('change')

  options_for: (role) ->
    options = @defaults

    if role
      for role in role.split(',')
        options = $.extend({}, options, @roles[role])

    options
