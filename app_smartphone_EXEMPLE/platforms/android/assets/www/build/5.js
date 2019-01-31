webpackJsonp([5],{

/***/ 420:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "HomePageModule", function() { return HomePageModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(81);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__home__ = __webpack_require__(426);
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

/***/ 426:
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
        this.zone = new __WEBPACK_IMPORTED_MODULE_0__angular_core__["NgZone"]({});
    }
    HomePage.prototype.waterToast = function () {
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
    HomePage.prototype.nightToast = function () {
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
    /*créer un noeud dataSensor dans la database
      dataSensor:
      dataName:
      dataValue:
    */
    HomePage.prototype.createValue = function (dataSensor, dataName, dataValue) {
        //Référence à la base de donnée Firebase
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/luminositySensor/"); //luminositySensor node dans la firebase
        //On passe nos 2 variable dans cette référence
        personRef.set({
            "name": dataName,
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
                return "Menthe";
            }
            case "4": {
                return "Ciboulette";
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
    HomePage.prototype.deleteValue = function (dataSensor) {
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/" + dataSensor + "/");
        personRef.remove(); //détruit tous le noeud et ses éléments enfants
    };
    //Ne détruit pas le noeud entier mais met à null les éléments
    HomePage.prototype.deleteSafePerson = function () {
        var personRef = __WEBPACK_IMPORTED_MODULE_2_firebase___default.a.database().ref("/person1/");
        personRef.update({
            firstName: null,
            lastName: null
        });
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
        selector: 'page-home',template:/*ion-inline-start:"C:\Users\Xavier\Desktop\PGA\Isalad\src\pages\home\home.html"*/'<ion-header>\n  <ion-navbar>\n      <button ion-button menuToggle>\n      <ion-icon name="menu"></ion-icon>\n    </button>\n \n    <ion-title>\n      ISalad\n    </ion-title>\n  </ion-navbar>\n</ion-header>\n\n<ion-content padding>\n\n<ion-grid>\n\n  <ion-row>\n    <ion-col>\n   \n      <div class="flower_pot"> \n         {{myPerson.nameFlower1}}\n             <img class="pot" src="assets/img/flower_pot.png"/>\n           <img class="flower"   src="{{\'assets/img/1/\' + myPerson.slot1 + \'.png\'}}"/>\n  \n      </div>\n    </ion-col>\n    <ion-col>\n    \n         <div class="flower_pot"> \n     {{myPerson.nameFlower2}}\n      <img src="assets/img/flower_pot.png"/>\n           <img class="flower"   src="{{\'assets/img/1/\' + myPerson.slot2 + \'.png\'}}"/>\n      </div>\n    </ion-col>\n  </ion-row>\n  <ion-row>\n  <ion-col>\n\n      <div class="flower_pot"> \n    {{myPerson.nameFlower3}}\n    <img src="assets/img/flower_pot.png"/>\n           <img class="flower"   src="{{\'assets/img/1/\' + myPerson.slot3 + \'.png\'}}"/>\n    </div>\n  </ion-col>\n  <ion-col>\n\n      <div class="flower_pot"> \n      {{myPerson.nameFlower4}}\n \n    <img src="assets/img/flower_pot.png"/>\n           <img class="flower"   src="{{\'assets/img/1/\' + myPerson.slot4 + \'.png\'}}"/>\n    </div>\n  </ion-col>\n</ion-row>\n</ion-grid>\n\n  \n\n<ion-grid> <ion-list>\n  <ion-row>\n    <ion-col>\n <div >\n\n    <ion-label>Emplacement 1</ion-label>\n  \n      <ion-select [(ngModel)]="value1" (ionChange)="updateFlower1(value1)" multiple="false" cancelText="Annuler" okText="Valider"><ion-option value="1" selected="true">Basilic</ion-option>\n      <ion-option value="2">Persil</ion-option>\n      <ion-option value="3">Menthe</ion-option>\n      <ion-option value="4">Ciboulette</ion-option>\n    </ion-select>\n\n\n  </div>\n    </ion-col>\n\n  <ion-col>\n <div >\n\n\n    <ion-label>Emplacement 2</ion-label>\n    <ion-select [(ngModel)]="value2" (ionChange)="updateFlower2(value2)" multiple="false" cancelText="Annuler" okText="Valider">  <ion-option value="1" >Basilic</ion-option>\n      <ion-option value="2" selected="true">Persil</ion-option>\n      <ion-option value="3">Menthe</ion-option>\n      <ion-option value="4">Ciboulette</ion-option>\n    </ion-select>\n \n  </div>\n  </ion-col>\n  </ion-row>\n\n\n  <ion-row>\n  <ion-col>\n   <div>\n  \n    <ion-label>Emplacement 3</ion-label>\n    <ion-select [(ngModel)]="value3" (ionChange)="updateFlower3(value3)" multiple="false" cancelText="Annuler" okText="Valider"> <ion-option value="1" >Basilic</ion-option>\n      <ion-option value="2">Persil</ion-option>\n      <ion-option value="3" selected="true">Menthe</ion-option>\n      <ion-option value="4">Ciboulette</ion-option>\n    </ion-select>\n\n    </div>\n  </ion-col>\n\n<ion-col>\n <div>\n\n    <ion-label>Emplacement 4</ion-label>\n    <ion-select [(ngModel)]="value4" (ionChange)="updateFlower4(value4)" multiple="false" cancelText="Annuler" okText="Valider">\n      <ion-option value="1" selected="true" >Basilic</ion-option>\n      <ion-option value="2">Persil</ion-option>\n      <ion-option value="3">Menthe</ion-option>\n      <ion-option value="4" >Ciboulette</ion-option>\n    </ion-select>\n\n    </div>\n  </ion-col>\n  </ion-row>\n  </ion-list>\n\n\n</ion-grid>\n\n\n<!--\n  <ion-list>\n\n<!--Label et champ de texte -->\n<!--\n   <ion-item>\n      <ion-label fixed>Type</ion-label>\n      <ion-input type="text" [(ngModel)]="dataSensor"></ion-input>\n    </ion-item>\n\n    <ion-item>\n      <ion-label fixed>Name</ion-label>\n      <ion-input type="text" [(ngModel)]="dataName"></ion-input>\n    </ion-item>\n\n    <ion-item>\n      <ion-label fixed>Value</ion-label>\n      <ion-input type="text" [(ngModel)]="dataValue"></ion-input>\n    </ion-item>\n\n  </ion-list>\n\nCreate Button--><!--\n  <button ion-button block (click)="createValue(dataSensor, dataName, dataValue)">\n    Create Field\n  </button>\n\n\n<!--Update Button--><!--\n  <button ion-button block (click)="updateValue(dataSensor, dataName, dataValue)">\n    Update Field\n  </button>\n\n<!--Delete Button--><!--\n  <button ion-button block (click)="deleteValue(dataSensor)">\n    Delete Field\n  </button>\n\n\n\n\n<!--Display Person -->\n\n\n<!--\n<p> luminosity: {{myPerson.luminosity}}</p>\n\n\n\n<!--Update Luminosity--><!--\n<ion-item>\n  <ion-range [(ngModel)]="brightness" (ionChange)="updateLuminosity(brightness)">\n    <ion-icon range-left small name="sunny"></ion-icon>\n    <ion-icon range-right name="sunny"></ion-icon>\n  </ion-range>\n</ion-item>\n -->\n\n\n\n\n\n <!--UATREASDFASF\n  <ion-icon  md="md-rainy" item-start></ion-icon>\n  Humidity\n  <ion-badge item-end>{{myPerson.humidity}}</ion-badge>\n</ion-item>\n <ion-item>\n\n  <ion-icon md="md-sunny" item-start></ion-icon>\n  Luminosity\n  <ion-badge item-end>{{myPerson.luminosity}}</ion-badge>\n</ion-item>\n\n <ion-item>\n  <ion-icon md="md-water" item-start></ion-icon>\n  Moisture\n  <ion-badge item-end>{{myPerson.moisture}}</ion-badge>\n</ion-item>\n\n <ion-item>\n  <ion-icon md="md-speedometer" item-start></ion-icon>\n  Pressure\n  <ion-badge item-end>{{myPerson.pressure}}</ion-badge>\n</ion-item>\n\n <ion-item>\n  <ion-icon md="md-thermometer" item-start></ion-icon>\n  Temperature\n  <ion-badge item-end>{{myPerson.temperature}}</ion-badge>\n</ion-item>\n\n <ion-item>\n  <ion-icon md="md-beaker" item-start></ion-icon>\n  Water Level\n  <ion-badge item-end>\n    \n    <div *ngIf="myPerson.water==1"> \n    Veuillez remplir\n    </div>\n\n  </ion-badge>\n   <ion-item>\n-->\n<!--Create Button-->\n\n\n\n\n</ion-content>\n'/*ion-inline-end:"C:\Users\Xavier\Desktop\PGA\Isalad\src\pages\home\home.html"*/
    }),
    __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["f" /* NavController */], __WEBPACK_IMPORTED_MODULE_0__angular_core__["NgZone"], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["i" /* ToastController */]])
], HomePage);

//# sourceMappingURL=home.js.map

/***/ })

});
//# sourceMappingURL=5.js.map