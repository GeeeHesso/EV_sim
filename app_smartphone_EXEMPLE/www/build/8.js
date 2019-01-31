webpackJsonp([8],{

/***/ 419:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "CameraPageModule", function() { return CameraPageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(81);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__camera__ = __webpack_require__(555);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};



var CameraPageModule = (function () {
    function CameraPageModule() {
    }
    return CameraPageModule;
}());
CameraPageModule = __decorate([
    Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["NgModule"])({
        declarations: [
            __WEBPACK_IMPORTED_MODULE_2__camera__["a" /* CameraPage */],
        ],
        imports: [
            __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["d" /* IonicPageModule */].forChild(__WEBPACK_IMPORTED_MODULE_2__camera__["a" /* CameraPage */]),
        ],
    })
], CameraPageModule);

//# sourceMappingURL=camera.module.js.map

/***/ }),

/***/ 555:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return CameraPage; });
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
 * Generated class for the CameraPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var CameraPage = (function () {
    function CameraPage(navCtrl, zone, navParams) {
        this.navCtrl = navCtrl;
        this.zone = zone;
        this.navParams = navParams;
        this.myPerson = {};
        this.zone = new __WEBPACK_IMPORTED_MODULE_0__angular_core__["NgZone"]({});
    }
    CameraPage.prototype.ionViewDidLoad = function () {
        var _this = this;
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        var storage = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.storage();
        var storageRef = storage.ref();
        var imgRef = storageRef.child('images/test.png');
        //.on() le code se souscrit au noeud et synchronise en temps réel
        personRef.on('value', function (personSnapshot) {
            _this.zone.run(function () {
                __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.storage().ref().child('images/test.png').getDownloadURL()
                    .then(function (response) { return _this.currentImage = response; })
                    .catch(function (error) { return console.log('error', error); });
                _this.myPerson = personSnapshot.val();
            });
        });
    };
    CameraPage.prototype.picturePi = function () {
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        personRef.update({
            camStatus: 1
        });
    };
    return CameraPage;
}());
CameraPage = __decorate([
    Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["Component"])({
        selector: 'page-camera',template:/*ion-inline-start:"C:\Users\Thomas\Desktop\app_smartphone\src\pages\camera\camera.html"*/'<!--\n  Generated template for the CameraPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header>\n\n  <ion-navbar>\n\n\n		<button ion-button menuToggle>\n		<ion-icon name="menu"></ion-icon>\n		</button>\n\n\n    <ion-title>Camera</ion-title>\n  </ion-navbar>\n\n</ion-header>\n\n\n<ion-content padding>\n	<ion-item>\n		<ion-title>\n		Dernière photo :\n		</ion-title>\n\n		<img src={{currentImage}} />\n\n\n\n	</ion-item>\n	<button ion-button outline  color="dark"  (click)="picturePi()">Actualiser</button>\n</ion-content>\n'/*ion-inline-end:"C:\Users\Thomas\Desktop\app_smartphone\src\pages\camera\camera.html"*/,
    }),
    __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["f" /* NavController */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["NgZone"], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["g" /* NavParams */]])
], CameraPage);

//# sourceMappingURL=camera.js.map

/***/ })

});
//# sourceMappingURL=8.js.map