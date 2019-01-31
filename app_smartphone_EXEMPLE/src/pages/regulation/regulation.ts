import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { NgZone } from '@angular/core';
import firebase from 'firebase';
/**
 * Generated class for the RegulationPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-regulation',
  templateUrl: 'regulation.html',
})
export class RegulationPage {
  public myPerson = {};
  public _LightCycle ;
	public _LightMin = 90;
	public _MoistMin = 100;
  public _TempMoy = 23;
  public _TempMax = 27;


  constructor(public navCtrl: NavController, public navParams: NavParams, private zone : NgZone) {
  this._LightCycle = new Object ();
  this._LightCycle.upper = 20;
  this._LightCycle.lower = 7;
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

  
updateLuminosityMin(brightness: number): void {
  const personRef: firebase.database.Reference = 
  firebase.database().ref(`/luminositySensor/`);
  personRef.update({ //update() met à jour les éléments du noeuds
   _LightMin : brightness
  })
}

updateMoistMin(brightness: number): void {
  const personRef: firebase.database.Reference = 
  firebase.database().ref(`/luminositySensor/`);
  personRef.update({ //update() met à jour les éléments du noeuds
   _MoistMin : brightness
  })
}

updateTempMoy(brightness: number): void {
  const personRef: firebase.database.Reference = 
  firebase.database().ref(`/luminositySensor/`);
  personRef.update({ //update() met à jour les éléments du noeuds
   _TempMoy : brightness
  })
}

updateTempMax(brightness: number): void {
  const personRef: firebase.database.Reference = 
  firebase.database().ref(`/luminositySensor/`);
  personRef.update({ //update() met à jour les éléments du noeuds
   _TempMax : brightness
  })
}

updateCycle(lower: number, upper: number): void {
  const personRef: firebase.database.Reference = 
  firebase.database().ref(`/luminositySensor/`);
  personRef.update({ //update() met à jour les éléments du noeuds
   _upper : upper,
   _lower : lower
  })
}



  reset(){
  this._LightCycle.upper = 20;
  this._LightCycle.lower = 7;
  this._LightMin = 90;
  this._MoistMin = 100;
  this._TempMoy = 23;
  this._TempMax = 27;
  }
}

