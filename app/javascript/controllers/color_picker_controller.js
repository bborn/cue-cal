import ColorPicker from 'stimulus-color-picker'
import '@simonwep/pickr/dist/themes/nano.min.css'
import Pickr from '@simonwep/pickr'


export default class extends ColorPicker {

  initialize() {
    super.initialize()
    this.onChange = this.onChange.bind(this)
    this.onClear = this.onClear.bind(this)
  }


  connect() {
    this.picker = Pickr.create({
      el: this.buttonTarget,
      container: this.element,
      theme: this.themeValue,
      default: this.inputTarget.value,
      swatches: this.swatches,
      components: this.componentOptions
    })

    this.picker.on('change', this.onChange)
    this.picker.on('clear', this.onClear)
  }

  get componentOptions() {
    return {
      preview: false,
      hue: false,

      interaction: {
        input: true,
        clear: true,
        save: false,
      },
    }
  }

  onChange(color, eventSource) {
    console.log('Color changed:', eventSource);
    this.inputTarget.value = null

    if (color) {
      this.inputTarget.value = color.toHEXA().toString()
      this.picker.setColor(this.inputTarget.value);
    }
    this.picker.hide()
  }

  onClear() {
    this.inputTarget.value = null
  }

  // // Callback when the color is saved
  onSave(color) {
    console.log('Color saved:', color)
  }


}
