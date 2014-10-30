app = module.exports = require('derby').createApp 'component-examples', __filename
app.serverUse module, 'derby-stylus'
app.loadViews __dirname
app.loadStyles __dirname+"/css"

app.component require 'd-image-crop'
app.component require 'd-light-box'
app.component require 'd-textarea'
app.component require 'd-pagedown'

components = [
    name: 'd-image-crop'
    descr: '<p>A simple image cropper.</p><p><img src="https://cloud.githubusercontent.com/assets/433707/4425354/d54aab9c-45a8-11e4-8c94-ceb935c4be1d.png"></p>'
    github: "https://github.com/ile/d-image-crop"
  ,
    name: 'd-light-box'
    descr: '<p>Very light lightbox.</p><p><img src="https://farm4.staticflickr.com/3766/13169486404_1342fc8c98_b.jpg" style="width:200px"></p>'
    github: "https://github.com/ile/d-light-box"
  ,
    name: 'd-textarea'
    descr: '<p>Expanding textarea.</p>'
    github: "https://github.com/ile/d-textarea"
  ,
    name: 'd-pagedown'
    descr: '<p>Markdown editor.</p><p><img src="https://cloud.githubusercontent.com/assets/433707/4852253/fa1fb49e-6079-11e4-8fdc-743660dea3cb.png"></p>'
    github: "https://github.com/ile/d-pagedown"
]

app.get '/', ->
  @model.set '_page.components', components
  @render 'home'
 
app.get '/:component', ->
  # @crop()  if @params.component is 'd-image-crop'
  @model.set '_page.component', find(@params.component)
  @render @params.component + '-example'

find = (name) ->
  a = (component for component in components when component.name is name)
  a[0]  if a?.length

app.proto.crop = (src) ->
  @model.del '_page.result'
  @model.set '_page.cropthis', src

app.proto.cropped = (e, crop) ->
  @model.del '_page.cropthis'
  @model.set '_page.result', JSON.stringify(crop)