// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import CalendarController from "./calendar_controller"
application.register("calendar", CalendarController)

import ColorPickerController from "./color_picker_controller"
application.register("color-picker", ColorPickerController)

import FlashesController from "./flashes_controller"
application.register("flashes", FlashesController)

import FlyoutController from "./flyout_controller"
application.register("flyout", FlyoutController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import PopupEditController from "./popup_edit_controller"
application.register("popup-edit", PopupEditController)
