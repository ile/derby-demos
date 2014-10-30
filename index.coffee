app = module.exports = require('derby').createApp 'component-examples', __filename
app.serverUse module, 'derby-stylus'
app.loadViews __dirname
app.loadStyles __dirname+"/css"

app.component require 'd-image-crop'
app.component require 'd-light-box'
app.component require 'd-pagedown'

app.get '/', ->
  components = [
      name: 'd-image-crop'
      descr: '<p><img src="https://cloud.githubusercontent.com/assets/433707/4425354/d54aab9c-45a8-11e4-8c94-ceb935c4be1d.png"></p>'
      github: "https://github.com/ile/d-image-crop"
    ,
      name: 'd-light-box'
      descr: '<p>Very light lightbox.</p>'
      github: "https://github.com/ile/d-light-box"
    ,
      name: 'd-pagedown'
      descr: '<p>Markdown editor.</p><p><img src="https://cloud.githubusercontent.com/assets/433707/4852253/fa1fb49e-6079-11e4-8fdc-743660dea3cb.png"></p>'
      github: "https://github.com/ile/d-pagedown"
  ]
  @model.set '_page.components', components
  @render 'home'
 
app.get '/:component', ->
  # @crop()  if @params.component is 'd-image-crop'
  @model.set '_page.component', @params.component
  @render @params.component + '-example'

app.proto.str = (s) -> JSON.stringify(s)

app.proto.crop = (src) ->
  @model.del '_page.result'
  @model.set '_page.cropthis', src

app.proto.cropped = (e, crop) ->
  @model.del '_page.cropthis'
  @model.set '_page.result', JSON.stringify(crop)