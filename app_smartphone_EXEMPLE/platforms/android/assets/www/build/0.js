webpackJsonp([0],{

/***/ 424:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "ThermoPageModule", function() { return ThermoPageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(81);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__thermo__ = __webpack_require__(430);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};



var ThermoPageModule = (function () {
    function ThermoPageModule() {
    }
    return ThermoPageModule;
}());
ThermoPageModule = __decorate([
    Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["NgModule"])({
        declarations: [
            __WEBPACK_IMPORTED_MODULE_2__thermo__["a" /* ThermoPage */],
        ],
        imports: [
            __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["d" /* IonicPageModule */].forChild(__WEBPACK_IMPORTED_MODULE_2__thermo__["a" /* ThermoPage */]),
        ],
    })
], ThermoPageModule);

//# sourceMappingURL=thermo.module.js.map

/***/ }),

/***/ 430:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ThermoPage; });
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
 * Generated class for the ThermoPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var ThermoPage = (function () {
    function ThermoPage(navCtrl, zone, toastCtrl) {
        this.navCtrl = navCtrl;
        this.zone = zone;
        this.toastCtrl = toastCtrl;
        this.myPerson = {};
        this.current = 0;
        this.number = 0;
        this.night = 0;
        this.zone = new __WEBPACK_IMPORTED_MODULE_0__angular_core__["NgZone"]({});
    }
    ThermoPage.prototype.waterToast = function () {
        if (this.number == 0) {
            this.number = 1;
            var toast = this.toastCtrl.create({
                message: 'eau détecté',
                showCloseButton: true,
                closeButtonText: 'Ok'
            });
            toast.present();
        }
    };
    ThermoPage.prototype.nightToast = function () {
        if (this.night == 0) {
            this.night = 1;
            var toast = this.toastCtrl.create({
                message: 'Nuit détecté',
                showCloseButton: true,
                closeButtonText: 'Ok'
            });
            toast.present();
        }
    };
    ThermoPage.prototype.ionViewDidLoad = function () {
        var _this = this;
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        //.on() le code se souscrit au noeud et synchronise en temps réel
        personRef.on('value', function (personSnapshot) {
            _this.zone.run(function () {
                _this.myPerson = personSnapshot.val();
            });
        });
    };
    return ThermoPage;
}());
ThermoPage = __decorate([
    Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["Component"])({
        selector: 'page-thermo',template:/*ion-inline-start:"C:\Users\Xavier\Desktop\PGA\Isalad\src\pages\thermo\thermo.html"*/'<!--\n  Generated template for the ThermoPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n  <ion-navbar>\n      <button ion-button menuToggle>\n      <ion-icon name="menu"></ion-icon>\n    </button>\n \n    <ion-title>\n      ISalad\n    </ion-title>\n  </ion-navbar>\n</ion-header>\n\n\n\n<ion-content padding>\n\n\n\n <ion-item>\n  <ion-icon md="md-speedometer" item-start></ion-icon>\n  Pressure\n  <ion-badge item-end>{{myPerson.pressure}}</ion-badge>\n</ion-item>\n\n<ion-item>\n  <ion-icon md="md-thermometer" item-start></ion-icon>\n  Temperature\n  <ion-badge item-end>{{myPerson.temperature}}</ion-badge>\n</ion-item>\n\n <ion-item>\n  <ion-icon md="md-beaker" item-start></ion-icon>\n  Water Level\n  <ion-badge item-end>\n    \n    <div *ngIf="myPerson.water==1"> \n    Veuillez remplir\n    </div>\n\n  </ion-badge>\n</ion-item>\n\n\n\n\n</ion-content>\n'/*ion-inline-end:"C:\Users\Xavier\Desktop\PGA\Isalad\src\pages\thermo\thermo.html"*/,
    }),
    __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["f" /* NavController */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["NgZone"], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["i" /* ToastController */]])
], ThermoPage);

//# sourceMappingURL=thermo.js.map

/***/ })

});
//# sourceMappingURL=0.js.map