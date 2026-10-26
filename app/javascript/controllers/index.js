// Import and register all your controllers from the importmap under controllers/*
import { application } from "controllers/application"

// Експліцитно підключаємо наш контролер динамічних форм
import NestedFormController from "./nested_form_controller"
application.register("nested-form", NestedFormController)

// Автозавантаження решти контролерів (якщо є)
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)