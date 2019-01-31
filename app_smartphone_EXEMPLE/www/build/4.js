webpackJsonp([4],{

/***/ 425:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "RegulationPageModule", function() { return RegulationPageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(81);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__regulation__ = __webpack_require__(609);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};



var RegulationPageModule = (function () {
    function RegulationPageModule() {
    }
    return RegulationPageModule;
}());
RegulationPageModule = __decorate([
    Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["NgModule"])({
        declarations: [
            __WEBPACK_IMPORTED_MODULE_2__regulation__["a" /* RegulationPage */],
        ],
        imports: [
            __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["d" /* IonicPageModule */].forChild(__WEBPACK_IMPORTED_MODULE_2__regulation__["a" /* RegulationPage */]),
        ],
    })
], RegulationPageModule);

//# sourceMappingURL=regulation.module.js.map

/***/ }),

/***/ 609:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return RegulationPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(81);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_firebase__ = __webpack_require__(279);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_firebase___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_firebase__);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};




/**
 * Generated class for the RegulationPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var RegulationPage = (function () {
    function RegulationPage(navCtrl, navParams, zone) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.zone = zone;
        this.myPerson = {};
        this._LightMin = 90;
        this._MoistMin = 100;
        this._TempMoy = 23;
        this._TempMax = 27;
        this._LightCycle = new Object();
        this._LightCycle.upper = 20;
        this._LightCycle.lower = 7;
        this.zone = new __WEBPACK_IMPORTED_MODULE_0__angular_core__["NgZone"]({});
    }
    RegulationPage.prototype.ionViewDidLoad = function () {
        var _this = this;
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        //.on() le code se souscrit au noeud et synchronise en temps réel
        personRef.on('value', function (personSnapshot) {
            _this.zone.run(function () {
                _this.myPerson = personSnapshot.val();
            });
        });
    };
    RegulationPage.prototype.updateLuminosityMin = function (brightness) {
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        personRef.update({
            _LightMin: brightness
        });
    };
    RegulationPage.prototype.updateMoistMin = function (brightness) {
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        personRef.update({
            _MoistMin: brightness
        });
    };
    RegulationPage.prototype.updateTempMoy = function (brightness) {
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        personRef.update({
            _TempMoy: brightness
        });
    };
    RegulationPage.prototype.updateTempMax = function (brightness) {
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        personRef.update({
            _TempMax: brightness
        });
    };
    RegulationPage.prototype.updateCycle = function (lower, upper) {
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        personRef.update({
            _upper: upper,
            _lower: lower
        });
    };
    RegulationPage.prototype.reset = function () {
        this._LightCycle.upper = 20;
        this._LightCycle.lower = 7;
        this._LightMin = 90;
        this._MoistMin = 100;
        this._TempMoy = 23;
        this._TempMax = 27;
    };
    return RegulationPage;
}());
RegulationPage = __decorate([
    Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["Component"])({
        selector: 'page-regulation',template:/*ion-inline-start:"C:\Users\Thomas\Desktop\app_smartphone\src\pages\regulation\regulation.html"*/'<!--\n  Generated template for the RegulationPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n\n\n  <ion-navbar>\n  	<button ion-button menuToggle>\n		<ion-icon name="menu"></ion-icon>\n	</button>\n\n    <ion-title>Régulation</ion-title>\n  </ion-navbar>\n\n</ion-header>\n\n\n<ion-content padding>\n\n<ion-item>\n    <ion-label>Cycle de lumière désiré : <strong>[{{_LightCycle.lower}}h à {{_LightCycle.upper}}h]</strong> </ion-label>\n    \n    <ion-range dualKnobs="true" [(ngModel)]="_LightCycle" min="0" max="24" step="1" snaps="true" (ionChange)="updateCycle(_LightCycle.lower, _LightCycle.upper )"></ion-range>\n</ion-item>\n\n<ion-item>\n	<ion-label>Luminosité minimum : <strong>[{{_LightMin}}]</strong></ion-label>\n	<ion-range min="0" max="200" step="10" snaps="true" color="primary" [(ngModel)]="_LightMin" (ionChange)="updateLuminosityMin(_LightMin)"></ion-range>\n</ion-item>\n\n <ion-item>\n    <ion-label>Humidité de la terre minimum : <strong>[{{_MoistMin}}]</strong></ion-label>\n    <ion-range min="0" max="400" step="25" snaps="true" color="secondary" [(ngModel)]="_MoistMin" (ionChange)="updateMoistMin(_MoistMin)"></ion-range>\n  </ion-item>\n\n <ion-item>\n    <ion-label>Température moyenne : <strong>[{{_TempMoy}} °C]</strong></ion-label>\n    <ion-range min="15" max="25" step="1" snaps="true" color="dark2" [(ngModel)]="_TempMoy" (ionChange)="updateTempMoy(_TempMoy)"></ion-range>\n  </ion-item>\n\n\n <ion-item>\n    <ion-label>Température max : <strong>[{{_TempMax}} °C]</strong></ion-label>\n    <ion-range min="15" max="35" step="1" snaps="true" color="dark2" [(ngModel)]="_TempMax" (ionChange)="updateTempMax(_TempMax)"></ion-range>\n  </ion-item>\n\n  <button ion-button color="light" (click)="reset()">Réinitialiser</button>\n\n</ion-content>\n'/*ion-inline-end:"C:\Users\Thomas\Desktop\app_smartphone\src\pages\regulation\regulation.html"*/,
    }),
    __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["f" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["g" /* NavParams */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["NgZone"]])
], RegulationPage);

//# sourceMappingURL=regulation.js.map

/***/ })

});
//# sourceMappingURL=4.js.map