import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import firebase from 'firebase';
import { NgZone } from '@angular/core';
/**
 * Generated class for the SettingsPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-settings',
  templateUrl: 'settings.html',
})
export class SettingsPage {
  public myPerson = {};
public relay; //relay sur le port D4
public relayPump; //relay sur le port D7
public relayVentilo; //relay sur le port D3
public Regulation;
  constructor(public navCtrl: NavController, private zone : NgZone,public navParams: NavParams) {
    this.relay = 0;
    this.relayPump = 0;
    this.relayVentilo = 0;
    this.Regulation=0;
  	this.zone = new NgZone({});
  }


switchRegulation(): void {
  const personRef: firebase.database.Reference = 
  firebase.database().ref(`/luminositySensor/`); 

  if( this.Regulation == 0){
    personRef.update({"Regulation" : 1})
    this.Regulation = 1;
  }
  else{
    personRef.update({"Regulation" : 0})
    this.Regulation = 0;
  }
}



switchRelayLight(): void {
  const personRef: firebase.database.Reference = 
  firebase.database().ref(`/luminositySensor/`); 

  if( this.relay == 0){
    personRef.update({"relay" : 1})
    this.relay = 1;
  }
  else{
    personRef.update({"relay" : 0})
    this.relay = 0;
  }
}

switchRelayPump(): void {
  const personRef: firebase.database.Reference = 
  firebase.database().ref(`/luminositySensor/`); 

  if( this.relayPump == 0){
    personRef.update({"relay2" : 1})
    this.relayPump = 1;
  }
  else{
    personRef.update({"relay2" : 0})
    this.relayPump = 0;
  }
}

switchRelayVentilo(): void {
  const personRef: firebase.database.Reference = 
  firebase.database().ref(`/luminositySensor/`); 

  if( this.relayVentilo == 0){
    personRef.update({"relay3" : 1})
    this.relayVentilo = 1;
  }
  else{
    personRef.update({"relay3" : 0})
    this.relayVentilo = 0;
  }
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

}
