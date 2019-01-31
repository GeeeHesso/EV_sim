import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import firebase from 'firebase';
import { NgZone } from '@angular/core';

/**
 * Generated class for the CameraPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-camera',
  templateUrl: 'camera.html',
})
export class CameraPage {
public myPerson = {};
public currentImage;


  constructor(public navCtrl: NavController, private zone : NgZone, public navParams: NavParams) {

this.zone = new NgZone({});

  }

ionViewDidLoad() {
  const personRef: firebase.database.Reference = 
  firebase.database().ref(`/luminositySensor/`);

   var storage = firebase.storage();
 var storageRef = storage.ref();
 var imgRef = storageRef.child('images/test.png');

  //.on() le code se souscrit au noeud et synchronise en temps réel
  personRef.on('value', personSnapshot => 
  {  this.zone.run(() =>{
    firebase.storage().ref().child('images/test.png').getDownloadURL()
    .then(response => this.currentImage= response)
    .catch(error =>console.log('error',error));
    this.myPerson = personSnapshot.val();

  });
    });
}
picturePi(){
	  const personRef: firebase.database.Reference = 
  firebase.database().ref(`/luminositySensor/`);
  personRef.update({ //update() met à jour les éléments du noeuds
   camStatus : 1
  })
}

}
