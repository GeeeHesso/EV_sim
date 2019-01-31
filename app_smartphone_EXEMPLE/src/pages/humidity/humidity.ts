import { Component } from '@angular/core';
import { IonicPage, NavController} from 'ionic-angular';
import firebase from 'firebase';
import { NgZone } from '@angular/core';
import {ToastController } from 'ionic-angular'
/**
 * Generated class for the HumidityPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-humidity',
  templateUrl: 'humidity.html',
})
export class HumidityPage {
public myPerson = {};
public number;
public night;

 current: number = 0;

  maxHumidity: number = 500;
      radius: number = 125;
  semicircle: boolean = false;

  constructor(public navCtrl: NavController, private zone : NgZone, public toastCtrl: ToastController) {
    this.number = 0;
    this.night = 0;


this.zone = new NgZone({});
  }




ionViewDidLoad() {
  const personRef: firebase.database.Reference = 
  firebase.database().ref(`/luminositySensor/`);
  //.on() le code se souscrit au noeud et synchronise en temps réel

  personRef.on('value', personSnapshot => 
  {  this.zone.run(() =>{

    this.myPerson = personSnapshot.val();
  });

    });

}



  getOverlayStyle() {
    let isSemi = this.semicircle;
    let transform = (isSemi ? '' : 'translateY(-50%) ') + 'translateX(-50%)';

    return {
      'top': isSemi ? 'auto' : '50%',
      'bottom': isSemi ? '5%' : 'auto', 
      'left': '50%',
      'transform': transform,
      '-moz-transform': transform,
      '-webkit-transform': transform,
      'font-size': this.radius / 2 + 'px'
    };

}

}

