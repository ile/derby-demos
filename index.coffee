app = module.exports = require('derby').createApp 'component-examples', __filename
app.serverUse module, 'derby-stylus'
app.loadViews __dirname
app.loadStyles __dirname+"/css"

app.component require 'd-image-crop'

app.get '/', ->
  components = [
    name: 'd-image-crop'
    descr: '<img src="https://cloud.githubusercontent.com/assets/433707/4425354/d54aab9c-45a8-11e4-8c94-ceb935c4be1d.png">'
  ]
  @model.set '_page.components', components
  @render 'home'
 
app.get '/d-image-crop', ->
  @crop()
  @render 'd-image-crop-example'

app.get '/:component', ->
  @render @params.component + '-example'

app.proto.str = (s) -> JSON.stringify(s)

app.proto.crop = ->
  @model.del '_page.result'
  @model.set '_page.cropthis', 'http://placebeard.it/640/480/notag'

app.proto.cropped = (e, crop) ->
  @model.del '_page.cropthis'
  @model.set '_page.result', JSON.stringify(crop)