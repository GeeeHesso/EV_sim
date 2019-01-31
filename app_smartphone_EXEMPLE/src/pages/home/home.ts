import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';
import firebase from 'firebase';
import { NgZone } from '@angular/core';
import {IonicPage, ToastController } from 'ionic-angular'

@IonicPage()
@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {

public myPerson = {};
public number;
public night;
public relay;
public showmodify;



current: number = 0;
maxHumidity: number = 500;
radius: number = 125;
semicircle: boolean = false;


constructor(public navCtrl: NavController, private zone : NgZone, public toastCtrl: ToastController) {
    this.number = 0;
    this.night = 0;
    this.relay = 0;
    this.showmodify = 0;


this.zone = new NgZone({});
  }




  


changeDate(UserTime : string): void {
  //Référence à la base de donnée Firebase
  const personRef: firebase.database.Reference = 
   firebase.database().ref(`/luminositySensor/`); //luminositySensor node dans la firebase
    //On passe nos 2 variable dans cette référence
  personRef.update({  //set est une méthode destructive
    "date" : UserTime,
  })

}
getFlowerName(slotValue : string): string {
  switch(slotValue) { 
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
}

updateFlower1(slotValue : string): void {
  //Référence à la base de donnée Firebase
  const personRef: firebase.database.Reference = 
   firebase.database().ref(`/luminositySensor/`); //luminositySensor node dans la firebase
    //On passe nos 2 variable dans cette référence
  personRef.update({  //set est une méthode destructive
    "slot1": slotValue,
    "nameFlower1" : this.getFlowerName(slotValue)
  })

}

updateFlower2(slotValue : string): void {
  //Référence à la base de donnée Firebase
  const personRef: firebase.database.Reference = 
   firebase.database().ref(`/luminositySensor/`); //luminositySensor node dans la firebase
    //On passe nos 2 variable dans cette référence
  personRef.update({  //set est une méthode destructive
    "slot2": slotValue,
    "nameFlower2" : this.getFlowerName(slotValue)
  })

}


updateFlower3(slotValue : string): void {
  //Référence à la base de donnée Firebase
  const personRef: firebase.database.Reference = 
   firebase.database().ref(`/luminositySensor/`); //luminositySensor node dans la firebase
    //On passe nos 2 variable dans cette référence
  personRef.update({  //set est une méthode destructive
    "slot3": slotValue,
    "nameFlower3" : this.getFlowerName(slotValue)
  })

}





updateFlower4(slotValue : string): void {
  //Référence à la base de donnée Firebase
  const personRef: firebase.database.Reference = 
   firebase.database().ref(`/luminositySensor/`); //luminositySensor node dans la firebase
    //On passe nos 2 variable dans cette référence
  personRef.update({  //set est une méthode destructive
    "slot4": slotValue,
    "nameFlower4" : this.getFlowerName(slotValue)
  })

}





switchRelay(): void {
  //Référence à la base de donnée Firebase
  const personRef: firebase.database.Reference = 
   firebase.database().ref(`/luminositySensor/`); //dataSensor node dans la firebase
    //On passe nos 2 variable dans cette référence
 
    if( this.relay == 0){
      personRef.update({"relay" : 1})
      this.relay = 1;
    }
    else{
      personRef.update({"relay" : 0})
     this.relay = 0;
    }


}



updateValue(dataSensor : string, dataName: string, dataValue: number): void {
  const personRef: firebase.database.Reference = 
  firebase.database().ref(`/${ dataSensor }/`);
  personRef.update({ //update() met à jour les éléments du noeuds
     "name" : dataName,
    "content" : dataValue
  })
}

updateLuminosity(brightness: number): void {
  const personRef: firebase.database.Reference = 
  firebase.database().ref(`/luminositySensor/`);
  personRef.update({ //update() met à jour les éléments du noeuds
   luminosity : brightness
  })
}




showModify(){
  if( this.showmodify == 0){
    this.showmodify = 1;
  }
  else{
    this.showmodify = 0;
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

