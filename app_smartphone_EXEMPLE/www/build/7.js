webpackJsonp([7],{

/***/ 421:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "HomePageModule", function() { return HomePageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(81);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__home__ = __webpack_require__(605);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_angular_svg_round_progressbar__ = __webpack_require__(280);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_angular_svg_round_progressbar___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_3_angular_svg_round_progressbar__);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};




var HomePageModule = (function () {
    function HomePageModule() {
    }
    return HomePageModule;
}());
HomePageModule = __decorate([
    Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["NgModule"])({
        declarations: [
            __WEBPACK_IMPORTED_MODULE_2__home__["a" /* HomePage */],
        ],
        imports: [
            __WEBPACK_IMPORTED_MODULE_3_angular_svg_round_progressbar__["RoundProgressModule"],
            __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["d" /* IonicPageModule */].forChild(__WEBPACK_IMPORTED_MODULE_2__home__["a" /* HomePage */])
        ],
        exports: [
            __WEBPACK_IMPORTED_MODULE_2__home__["a" /* HomePage */]
        ]
    })
], HomePageModule);

//# sourceMappingURL=home.module.js.map

/***/ }),

/***/ 605:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return HomePage; });
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





var HomePage = (function () {
    function HomePage(navCtrl, zone, toastCtrl) {
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
        this.relay = 0;
        this.showmodify = 0;
        this.zone = new __WEBPACK_IMPORTED_MODULE_0__angular_core__["NgZone"]({});
    }
    HomePage.prototype.changeDate = function (UserTime) {
        //Référence à la base de donnée Firebase
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/"); //luminositySensor node dans la firebase
        //On passe nos 2 variable dans cette référence
        personRef.update({
            "date": UserTime,
        });
    };
    HomePage.prototype.getFlowerName = function (slotValue) {
        switch (slotValue) {
            case "1": {
                return "Basilic";
            }
            case "2": {
                return "Persil";
            }
            case "3": {
                return "Ciboulette";
            }
            case "4": {
                return "Cerfeuil";
            }
            default: {
                return "Error";
            }
        }
    };
    HomePage.prototype.updateFlower1 = function (slotValue) {
        //Référence à la base de donnée Firebase
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/"); //luminositySensor node dans la firebase
        //On passe nos 2 variable dans cette référence
        personRef.update({
            "slot1": slotValue,
            "nameFlower1": this.getFlowerName(slotValue)
        });
    };
    HomePage.prototype.updateFlower2 = function (slotValue) {
        //Référence à la base de donnée Firebase
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/"); //luminositySensor node dans la firebase
        //On passe nos 2 variable dans cette référence
        personRef.update({
            "slot2": slotValue,
            "nameFlower2": this.getFlowerName(slotValue)
        });
    };
    HomePage.prototype.updateFlower3 = function (slotValue) {
        //Référence à la base de donnée Firebase
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/"); //luminositySensor node dans la firebase
        //On passe nos 2 variable dans cette référence
        personRef.update({
            "slot3": slotValue,
            "nameFlower3": this.getFlowerName(slotValue)
        });
    };
    HomePage.prototype.updateFlower4 = function (slotValue) {
        //Référence à la base de donnée Firebase
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/"); //luminositySensor node dans la firebase
        //On passe nos 2 variable dans cette référence
        personRef.update({
            "slot4": slotValue,
            "nameFlower4": this.getFlowerName(slotValue)
        });
    };
    HomePage.prototype.switchRelay = function () {
        //Référence à la base de donnée Firebase
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/"); //dataSensor node dans la firebase
        //On passe nos 2 variable dans cette référence
        if (this.relay == 0) {
            personRef.update({ "relay": 1 });
            this.relay = 1;
        }
        else {
            personRef.update({ "relay": 0 });
            this.relay = 0;
        }
    };
    HomePage.prototype.updateValue = function (dataSensor, dataName, dataValue) {
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/" + dataSensor + "/");
        personRef.update({
            "name": dataName,
            "content": dataValue
        });
    };
    HomePage.prototype.updateLuminosity = function (brightness) {
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        personRef.update({
            luminosity: brightness
        });
    };
    HomePage.prototype.showModify = function () {
        if (this.showmodify == 0) {
            this.showmodify = 1;
        }
        else {
            this.showmodify = 0;
        }
    };
    HomePage.prototype.ionViewDidLoad = function () {
        var _this = this;
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/");
        //.on() le code se souscrit au noeud et synchronise en temps réel
        personRef.on('value', function (personSnapshot) {
            _this.zone.run(function () {
                _this.myPerson = personSnapshot.val();
            });
        });
    };
    HomePage.prototype.getOverlayStyle = function () {
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
    return HomePage;
}());
HomePage = __decorate([
    Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["Component"])({
        selector: 'page-home',template:/*ion-inline-start:"C:\Users\Thomas\Desktop\app_smartphone\src\pages\home\home.html"*/'<ion-header>\n  <ion-navbar>\n      <button ion-button menuToggle>\n      <ion-icon name="menu"></ion-icon>\n    </button>\n \n    <ion-title>\n      ISalad\n    </ion-title>\n  </ion-navbar>\n</ion-header>\n\n<ion-content class="home" padding>\n\n\n<h2>Votre jardin</h2>\n <ion-item>\n\n    \n\n    <div *ngIf="myPerson.water==1"> \n    <p>Le bac est vide, veuillez le remplir.</p>\n    </div>\n        <div *ngIf="myPerson.water==0" > \n    <p>Il reste suffisamment d\'eau.</p>\n\n\n    </div>\n\n\n</ion-item>\n<ion-item>\n  <ion-label>Date de semis</ion-label>\n  <ion-label>{{myPerson.date}}</ion-label>\n\n</ion-item>\n\n<ion-grid>\n\n  <ion-row>\n    <ion-col>\n   \n      <div class="flower_pot"> \n         {{myPerson.nameFlower1}}\n             <img class="pot" src="assets/img/flower_pot.png"/>\n           <img class="flower"   src="{{\'assets/img/1/\' + myPerson.slot1 + \'.png\'}}"/>\n  \n      </div>\n    </ion-col>\n    <ion-col>\n    \n         <div class="flower_pot"> \n     {{myPerson.nameFlower2}}\n      <img src="assets/img/flower_pot.png"/>\n           <img class="flower"   src="{{\'assets/img/1/\' + myPerson.slot2 + \'.png\'}}"/>\n      </div>\n    </ion-col>\n  </ion-row>\n  <ion-row>\n  <ion-col>\n\n      <div class="flower_pot"> \n    {{myPerson.nameFlower3}}\n    <img src="assets/img/flower_pot.png"/>\n           <img class="flower"   src="{{\'assets/img/1/\' + myPerson.slot3 + \'.png\'}}"/>\n    </div>\n  </ion-col>\n  <ion-col>\n\n      <div class="flower_pot"> \n      {{myPerson.nameFlower4}}\n \n    <img src="assets/img/flower_pot.png"/>\n           <img class="flower"   src="{{\'assets/img/1/\' + myPerson.slot4 + \'.png\'}}"/>\n    </div>\n  </ion-col>\n</ion-row>\n</ion-grid>\n\n  <button ion-button color="light" (click)="showModify()">Modifier</button>\n\n<div *ngIf="showmodify==1">\n\n \n<ion-grid> \n<ion-list>\n  <ion-item>\n <ion-label>Changer la date de semis</ion-label>\n  <ion-datetime displayFormat="DD/MM/YYYY"   (ionChange)="changeDate(UserTime)" [(ngModel)]="UserTime" ></ion-datetime>\n </ion-item>\n \n  <ion-row>\n    <ion-col>\n <div >\n\n    <ion-label>Modifier le pot 1</ion-label>\n \n      <ion-select [(ngModel)]="value1" (ionChange)="updateFlower1(value1)" multiple="false" cancelText="Annuler" okText="Valider"><ion-option value="1">Basilic</ion-option>\n      <ion-option value="2">Persil</ion-option>\n      <ion-option value="3">Ciboulette</ion-option>\n      <ion-option value="4">Cerfeuille</ion-option>\n      </ion-select>\n\n\n\n  </div>\n    </ion-col>\n\n  <ion-col>\n<div>\n\n    <ion-label>Modifier le pot 2</ion-label>\n    <ion-select [(ngModel)]="value2" (ionChange)="updateFlower2(value2)" multiple="false" cancelText="Annuler" okText="Valider">  <ion-option value="1" >Basilic</ion-option>\n      <ion-option value="2">Persil</ion-option>\n      <ion-option value="3">Ciboulette</ion-option>\n      <ion-option value="4">Cerfeuille</ion-option>\n    </ion-select>\n \n  </div>\n  </ion-col>\n  </ion-row>\n\n\n  <ion-row>\n  <ion-col>\n   <div>\n  \n    <ion-label>Modifier le pot 3</ion-label>\n    <ion-select [(ngModel)]="value3" (ionChange)="updateFlower3(value3)" multiple="false" cancelText="Annuler" okText="Valider"> <ion-option value="1" >Basilic</ion-option>\n      <ion-option value="2">Persil</ion-option>\n      <ion-option value="3" >Ciboulette</ion-option>\n      <ion-option value="4">Cerfeuille</ion-option>\n    </ion-select>\n\n    </div>\n  </ion-col>\n\n<ion-col>\n <div>\n\n    <ion-label>Modifier le pot 4</ion-label>\n    <ion-select [(ngModel)]="value4" (ionChange)="updateFlower4(value4)" multiple="false" cancelText="Annuler" okText="Valider">\n      <ion-option value="1" >Basilic</ion-option>\n      <ion-option value="2">Persil</ion-option>\n      <ion-option value="3">Ciboulette</ion-option>\n      <ion-option value="4" >Cerfeuille</ion-option>\n    </ion-select>\n\n    </div>\n  </ion-col>\n  </ion-row>\n  </ion-list>\n\n\n</ion-grid>\n\n\n\n</div>\n\n\n\n\n\n\n\n</ion-content>\n'/*ion-inline-end:"C:\Users\Thomas\Desktop\app_smartphone\src\pages\home\home.html"*/
    }),
    __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["f" /* NavController */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["NgZone"], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["i" /* ToastController */]])
], HomePage);

//# sourceMappingURL=home.js.map

/***/ })

});
//# sourceMappingURL=7.js.map