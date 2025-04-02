// Import and register all your controllers from the importmap via controllers/**/*_controller
// import { application } from "controllers/application"
// import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
// eagerLoadControllersFrom("controllers", application)

// import { application } from "./application";
// import TaskFormController from "./task_form_controller";

// application.register("task-form", TaskFormController);

// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)