Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

Masonry = require 'masonry-layout'
tc = require 'teacup'

require 'jquery-ui'

HubChannel = Backbone.Radio.channel 'hubby'

#################################
# templates
#################################
{ capitalize } = require 'agate/src/apputil'


compare_meeting_item = (a,b) ->
  if a.item_order < b.item_order
    return -1
  if a.item_order > b.item_order
    return 1
  return 0

make_meeting_items = (meeting) ->
  meeting_items = []
  items = meeting.items
  for item in meeting.items
    mitem = item.lgr_meeting_item
    meeting_items.push item.lgr_meeting_item
  meeting_items.sort compare_meeting_item
  meeting_items

make_item_object = (meeting) ->
  Items = {}
  for item in meeting.items
    Items[item.id] = item
  Items
  

show_meeting_template = tc.renderable (meeting) ->
  meeting.meeting_items = make_meeting_items meeting
  meeting.Items = make_item_object meeting
  window.meeting = meeting
  tc.div '.hubby-meeting-header', ->
    tc.div '.hubby-meeting-header-agenda', ->
      tc.text 'Agenda: ' + meeting.agenda_status
    tc.div '.hubby-meeting-header-minutes', ->
      tc.text 'Minutes: ' + meeting.minutes_status
  tc.div '.hubby-meeting-item-list', ->
    agenda_section = 'start'
    for mitem in meeting.meeting_items
      item = meeting.Items[mitem.item_id]
      #console.log "ITEM", item
      if mitem.type != agenda_section and mitem.type
        agenda_section = mitem.type
        section_header = capitalize agenda_section + ' Agenda'
        tc.h3 '.hubby-meeting-agenda-header', section_header
      tc.div '.hubby-meeting-item', ->
        tc.div '.hubby-meeting-item-info', ->
          tc.div '.hubby-meeting-item-agenda-num', mitem.agenda_num
          tc.div '.hubby-meeting-item-fileid', item.file_id
          tc.div '.hubby-meeting-item-status', item.status
        tc.div '.hubby-meeting-item-content', ->
          tc.p '.hubby-meeting-item-text', item.title
          if item.attachments != undefined and item.attachments.length
            marker = "One Attachment"
            if item.attachments.length > 1
              marker = "#{item.attachments.length} Attachments"
            tc.span '.hubby-meeting-item-attachment-marker', marker
            tc.div '.hubby-meeting-item-attachments', ->
              for att in item.attachments
                tc.div ->
                  url = "http://hattiesburg.legistar.com/#{att.link}"
                  tc.a href:url, att.name
                  
          
##################################################################
#################################

class ShowMeetingView extends Backbone.Marionette.View
  template: show_meeting_template
  
  onDomRefresh: () ->
    attachments = $ '.hubby-meeting-item-attachments'
    attachments.hide()
    #attachments.draggable()
    $('.hubby-meeting-item-info').click ->
      $(this).next().toggle()
    $('.hubby-meeting-item-attachment-marker').click ->
      $(this).next().toggle()
    $('.hubby-meeting-item-action-marker').click ->
      if $(this).hasClass('itemaction-loaded')
        $(this).next().toggle()
      else
        itemid = $(this).attr('id')
        url = '/hubby/frag/itemactions/' + itemid
        $(this).next().load(url)
        $(this).addClass('itemaction-loaded')
      
  
module.exports = ShowMeetingView
  
