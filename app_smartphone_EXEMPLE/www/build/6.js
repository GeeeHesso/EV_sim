webpackJsonp([6],{

/***/ 423:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "HumidityPageModule", function() { return HumidityPageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(81);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__humidity__ = __webpack_require__(607);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_angular_svg_round_progressbar__ = __webpack_require__(280);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_angular_svg_round_progressbar___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_3_angular_svg_round_progressbar__);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};




var HumidityPageModule = (function () {
    function HumidityPageModule() {
    }
    return HumidityPageModule;
}());
HumidityPageModule = __decorate([
    Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["NgModule"])({
        declarations: [
            __WEBPACK_IMPORTED_MODULE_2__humidity__["a" /* HumidityPage */],
        ],
        imports: [
            __WEBPACK_IMPORTED_MODULE_3_angular_svg_round_progressbar__["RoundProgressModule"],
            __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["d" /* IonicPageModule */].forChild(__WEBPACK_IMPORTED_MODULE_2__humidity__["a" /* HumidityPage */]),
        ],
        exports: [
            __WEBPACK_IMPORTED_MODULE_2__humidity__["a" /* HumidityPage */]
        ]
    })
], HumidityPageModule);

//# sourceMappingURL=humidity.module.js.map

/***/ }),

/***/ 607:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return HumidityPage; });
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
 * Generated class for the HumidityPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var HumidityPage = (function () {
    function HumidityPage(navCtrl, zone, toastCtrl) {
        this.navCtrl = navCtrl;
        this.zone = zone;
        this.toastCtrl = toastCtrl;
        this.myPerson = {};
        this.current = 0;
        this.maxHumidity = 500;
        this.radius = 125;
        this.semicircle = false;
        this.number = 0;
        this.night = 0;
        this.zone = new __WEBPACK_IMPORTED_MODULE_0__angular_core__["NgZone"]({});
    }
    HumidityPage.prototype.ionViewDidLoad = function () {
        var _this = this;
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        //.on() le code se souscrit au noeud et synchronise en temps réel
        personRef.on('value', function (personSnapshot) {
            _this.zone.run(function () {
                _this.myPerson = personSnapshot.val();
            });
        });
    };
    HumidityPage.prototype.getOverlayStyle = function () {
        var isSemi = this.semicircle;
        var transform = (isSemi ? '' : 'translateY(-50%) ') + 'translateX(-50%)';
        return {
            'top': isSemi ? 'auto' : '50%',
            'bottom': isSemi ? '5%' : 'auto',
            'left': '50%',
            'transform': transform,
            '-moz-transform': transform,
            '-webkit-transform': transform,
            'font-size': this.radius / 2 + 'px'
        };
    };
    return HumidityPage;
}());
HumidityPage = __decorate([
    Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["Component"])({
        selector: 'page-humidity',template:/*ion-inline-start:"C:\Users\Thomas\Desktop\app_smartphone\src\pages\humidity\humidity.html"*/'<ion-header>\n  <ion-navbar>\n      <button ion-button menuToggle>\n      <ion-icon name="menu"></ion-icon>\n    </button>\n \n    <ion-title>\n      ISalad\n    </ion-title>\n  </ion-navbar>\n</ion-header>\n\n<ion-content padding>\n\n\n\n <ion-item>\n\n<div class="progress-container">\n  Humidité de la terre\n<div class="progress-wrapper">\n\n\n\n  <div class="current" [ngStyle]="getOverlayStyle()">{{myPerson.moisture}}</div>\n\n<round-progress [color]="\'#4ddf1a\'"   [background]="\'#b4e4a3\'" [current]="myPerson.moisture" \n[max]="maxHumidity" [responsive]="true" [radius]="125" [stroke]="12"  [duration]="1500" [animation]="\'easeInOutBack\'" ></round-progress>\n\n</div>\n    </div>\n    <!--\n    <div *ngIf="myPerson.luminosity<=500"> \n    {{nightToast()}}\n\n    </div> -->\n\n\n</ion-item>\n\n\n\n\n</ion-content>\n'/*ion-inline-end:"C:\Users\Thomas\Desktop\app_smartphone\src\pages\humidity\humidity.html"*/,
    }),
    __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["f" /* NavController */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["NgZone"], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["i" /* ToastController */]])
], HumidityPage);

//# sourceMappingURL=humidity.js.map

/***/ })

});
//# sourceMappingURL=6.js.map