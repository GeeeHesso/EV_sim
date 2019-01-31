import { Component, ViewChild } from '@angular/core';
import { Platform } from 'ionic-angular';
import { StatusBar } from '@ionic-native/status-bar';
import { SplashScreen } from '@ionic-native/splash-screen';
import firebase from 'firebase';
import {Nav } from 'ionic-angular';
import { FirstRunPage } from '../pages/pages';

@Component({

  template: `<ion-menu [content]="content">
    <ion-header>
      <ion-toolbar>
        <ion-title>Menu</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content>
      <ion-list>
        <button menuClose ion-item *ngFor="let p of pages" (click)="openPage(p)">
          {{p.title}}
        </button>
      </ion-list>
    </ion-content>

  </ion-menu>
  <ion-nav #content [root]="rootPage"></ion-nav>`

})
export class MyApp {
  rootPage = FirstRunPage;
  @ViewChild(Nav) nav: Nav;

  pages: any[] = [
    { title: 'Accueil', component: 'HomePage' },
    { title: 'Prises', component: 'TabsPage' },
    { title: 'Leurres', component: 'SettingsPage'},
    { title: 'Pêcheurs', component: 'HistoricPage' },
    { title: 'Spots', component: 'RegulationPage' },
    { title: 'Cannes', component: 'CameraPage' },
  ]

  constructor(platform: Platform, statusBar: StatusBar, splashScreen: SplashScreen) {
    platform.ready().then(() => {
      // Okay, so the platform is ready and our plugins are available.
      // Here you can do any higher level native things you might need.
      statusBar.styleDefault();
      splashScreen.hide();
    });
  }

    openPage(page) {
    // Reset the content nav to have just this page
    // we wouldn't want the back button to show in this scenario
    this.nav.setRoot(page.component);
  }
}

//Initializiing Firebase

firebase.initializeApp({
  apiKey: "AIzaSyDNnH8dOO5DLfXbHAdZ2srfvH4K1rwgWuo",
  authDomain: "wallisfishing.firebaseapp.com",
  databaseURL: "https://wallisfishing.firebaseio.com",
  projectId: "wallisfishing",
  storageBucket: "wallisfishing.appspot.com",
 messagingSenderId: "325376839392"
});