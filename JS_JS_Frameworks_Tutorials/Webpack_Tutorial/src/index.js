import { run } from "./app/app";
import { AlertService } from "./app/alert.service";
import { ComponentService } from "./app/component.service";
import "./main.scss";
import "bootstrap";

const alertService = new AlertService();
const componentService = new ComponentService();
console.log("Hello from index.js 8:36");

run(alertService, componentService);