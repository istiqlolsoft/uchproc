/*
 * Copyright (C) 2015 - present Instructure, Inc.
 *
 * This file is part of Canvas.
 *
 * Canvas is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Affero General Public License as published by the Free
 * Software Foundation, version 3 of the License.
 *
 * Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
 * A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
 * details.
 *
 * You should have received a copy of the GNU Affero General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import $ from 'jquery'
import EditorConfig from '@canvas/rce/tinymce.config'

let INST = null
const largeScreenWidth = 1300
const dom_id = 'some_textarea'
const fake_tinymce = {baseURL: '/base/url'}
const toolbar1 =
  // eslint-disable-next-line no-useless-concat
  'bold,italic,underline,forecolor,backcolor,removeformat,' + 'alignleft,aligncenter,alignright'
const toolbar2 =
  'outdent,indent,superscript,subscript,bullist,numlist,table,' +
  'media,instructure_links,unlink,instructure_image,' +
  'instructure_equation'
const toolbar3 = 'ltr,rtl,fontsizeselect,formatselect,check_a11y'

QUnit.module('EditorConfig', {
  setup() {
    INST = {}
    INST.editorButtons = []
    INST.maxVisibleEditorButtons = 20
    window.ENV = {
      FEATURES: {}
    }
  },
  teardown() {
    INST = {}
    window.ENV = {
      FEATURES: {}
    }
  }
})

test('default config has static attributes', () => {
  INST.maxVisibleEditorButtons = 2
  const config = new EditorConfig(fake_tinymce, INST, largeScreenWidth, dom_id)
  const schema = config.defaultConfig()
  equal(schema.skin, false)
})

test('default config includes Lato font-family', () => {
  const config = new EditorConfig(fake_tinymce, INST, largeScreenWidth, dom_id)
  const schema = config.defaultConfig()
  const availableFonts = schema.font_formats
  const fontIndex = availableFonts.indexOf('Lato')
  ok(fontIndex > -1)
})

test('default config includes Architects Daughter font-family', () => {
  const config = new EditorConfig(fake_tinymce, INST, largeScreenWidth, dom_id)
  const schema = config.defaultConfig()
  const availableFonts = schema.font_formats
  const fontIndex = availableFonts.indexOf('Architects Daughter')
  ok(fontIndex > -1)
})

test('config includes Balsamiq Sans font when elemenetary theme flag is on', () => {
  const config = new EditorConfig(fake_tinymce, INST, largeScreenWidth, dom_id)
  window.ENV.FEATURES.canvas_k6_theme = true
  const schema = config.defaultConfig()
  const availableFonts = schema.font_formats
  const fontIndex = availableFonts.indexOf('Balsamiq Sans')
  ok(fontIndex > -1)
})

test('it builds a selector from the id', () => {
  const config = new EditorConfig(fake_tinymce, INST, largeScreenWidth, dom_id)
  const schema = config.defaultConfig()
  equal(schema.selector, '#some_textarea')
})

test('browser spellcheck enabled by default', () => {
  const config = new EditorConfig(fake_tinymce, INST, largeScreenWidth, dom_id)
  const schema = config.defaultConfig()
  equal(schema.browser_spellcheck, true)
})

QUnit.module('Tinymce Config Integration', {
  setup() {
    $('body').append('<textarea id=a42></textarea>')
  },
  teardown() {
    $('textarea#a42').remove()
  }
})
