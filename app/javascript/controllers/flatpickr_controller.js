import Flatpickr from 'stimulus-flatpickr'

import { French } from 'flatpickr/dist/l10n/fr.js'

export default class extends Flatpickr {
  initialize() {
    this.config = {
      locale: French
    }
  }
}