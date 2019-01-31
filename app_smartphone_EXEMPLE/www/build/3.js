webpackJsonp([3],{

/***/ 424:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "SettingsPageModule", function() { return SettingsPageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(81);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__settings__ = __webpack_require__(608);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};



var SettingsPageModule = (function () {
    function SettingsPageModule() {
    }
    return SettingsPageModule;
}());
SettingsPageModule = __decorate([
    Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["NgModule"])({
        declarations: [
            __WEBPACK_IMPORTED_MODULE_2__settings__["a" /* SettingsPage */],
        ],
        imports: [
            __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["d" /* IonicPageModule */].forChild(__WEBPACK_IMPORTED_MODULE_2__settings__["a" /* SettingsPage */]),
        ],
    })
], SettingsPageModule);

//# sourceMappingURL=settings.module.js.map

/***/ }),

/***/ 608:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return SettingsPage; });
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
 * Generated class for the SettingsPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var SettingsPage = (function () {
    function SettingsPage(navCtrl, zone, navParams) {
        this.navCtrl = navCtrl;
        this.zone = zone;
        this.navParams = navParams;
        this.myPerson = {};
        this.relay = 0;
        this.relayPump = 0;
        this.relayVentilo = 0;
        this.Regulation = 0;
        this.zone = new __WEBPACK_IMPORTED_MODULE_0__angular_core__["NgZone"]({});
    }
    SettingsPage.prototype.switchRegulation = function () {
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        if (this.Regulation == 0) {
            personRef.update({ "Regulation": 1 });
            this.Regulation = 1;
        }
        else {
            personRef.update({ "Regulation": 0 });
            this.Regulation = 0;
        }
    };
    SettingsPage.prototype.switchRelayLight = function () {
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        if (this.relay == 0) {
            personRef.update({ "relay": 1 });
            this.relay = 1;
        }
        else {
            personRef.update({ "relay": 0 });
            this.relay = 0;
        }
    };
    SettingsPage.prototype.switchRelayPump = function () {
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        if (this.relayPump == 0) {
            personRef.update({ "relay2": 1 });
            this.relayPump = 1;
        }
        else {
            personRef.update({ "relay2": 0 });
            this.relayPump = 0;
        }
    };
    SettingsPage.prototype.switchRelayVentilo = function () {
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        if (this.relayVentilo == 0) {
            personRef.update({ "relay3": 1 });
            this.relayVentilo = 1;
        }
        else {
            personRef.update({ "relay3": 0 });
            this.relayVentilo = 0;
        }
    };
    SettingsPage.prototype.ionViewDidLoad = function () {
        var _this = this;
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        //.on() le code se souscrit au noeud et synchronise en temps réel
        personRef.on('value', function (personSnapshot) {
            _this.zone.run(function () {
                _this.myPerson = personSnapshot.val();
            });
        });
    };
    return SettingsPage;
}());
SettingsPage = __decorate([
    Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["Component"])({
        selector: 'page-settings',template:/*ion-inline-start:"C:\Users\Thomas\Desktop\app_smartphone\src\pages\settings\settings.html"*/'<!--\n  Generated template for the SettingsPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n  <ion-navbar>\n      <button ion-button menuToggle>\n      <ion-icon name="menu"></ion-icon>\n    </button>\n \n    <ion-title>\n      Paramètres\n    </ion-title>\n  </ion-navbar>\n\n</ion-header>\n\n\n<ion-content padding>\n<ion-item>\n<p> Avant toutes choses : désactivez la régulation\n</ion-item>\n\n\n<ion-list>\n\n<ion-item>\n   <ion-label>Régulation   </ion-label>\n   \n     <ion-label> \n       <div *ngIf="myPerson.Regulation==1" class="flower_pot">     \n         <ion-label><img class="pot" src="assets/switch_on.png"  (click)="switchRegulation()"/></ion-label>\n        </div> \n\n      <div *ngIf="myPerson.Regulation==0" class="flower_pot">         \n        <ion-label>    <img class="pot" src="assets/switch_off.png" (click)="switchRegulation()"/> </ion-label>\n      </div>\n    </ion-label>\n</ion-item>\n\n\n<ion-item>\n   <ion-label>Lumières   </ion-label>\n   \n     <ion-label> \n       <div *ngIf="myPerson.relay==1" class="flower_pot">     \n         <ion-label><img class="pot" src="assets/switch_on.png"  (click)="switchRelayLight()"/></ion-label>\n        </div> \n\n      <div *ngIf="myPerson.relay==0" class="flower_pot">         \n        <ion-label>    <img class="pot" src="assets/switch_off.png" (click)="switchRelayLight()"/> </ion-label>\n      </div>\n    </ion-label>\n</ion-item>\n\n<ion-item>\n   <ion-label>Pompes   </ion-label>\n   \n     <ion-label> \n       <div *ngIf="myPerson.relay2==1" class="flower_pot">     \n         <ion-label><img class="pot" src="assets/switch_on.png"  (click)="switchRelayPump()"/></ion-label>\n        </div> \n\n      <div *ngIf="myPerson.relay2==0" class="flower_pot">         \n        <ion-label>    <img class="pot" src="assets/switch_off.png" (click)="switchRelayPump()"/> </ion-label>\n      </div>\n    </ion-label>\n</ion-item>\n\n<ion-item>\n   <ion-label>Ventilateur   </ion-label>\n   \n     <ion-label> \n       <div *ngIf="myPerson.relay3==1" class="flower_pot">     \n         <ion-label><img class="pot" src="assets/switch_on.png"  (click)="switchRelayVentilo()"/></ion-label>\n        </div> \n\n      <div *ngIf="myPerson.relay3==0" class="flower_pot">         \n        <ion-label>    <img class="pot" src="assets/switch_off.png" (click)="switchRelayVentilo()"/> </ion-label>\n      </div>\n    </ion-label>\n</ion-item>\n\n\n</ion-list>\n\n</ion-content>\n'/*ion-inline-end:"C:\Users\Thomas\Desktop\app_smartphone\src\pages\settings\settings.html"*/,
    }),
    __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["f" /* NavController */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["NgZone"], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["g" /* NavParams */]])
], SettingsPage);

//# sourceMappingURL=settings.js.map

/***/ })

});
//# sourceMappingURL=3.js.map