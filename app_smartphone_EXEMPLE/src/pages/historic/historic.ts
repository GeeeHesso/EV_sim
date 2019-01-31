import { Component, ViewChild } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { Chart } from 'chart.js';
/**
 * Generated class for the HistoricPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-historic',
  templateUrl: 'historic.html',
})
export class HistoricPage {

    @ViewChild('lineCanvas') lineCanvas;

   lineChart: any;
  constructor(public navCtrl: NavController, public navParams: NavParams) {
  }

    ionViewDidLoad() {
 

 
        this.lineChart = new Chart(this.lineCanvas.nativeElement, {
 
            type: 'line',
            data: {
                labels: ["2", "4","6", "8", "10", "12", "14", "16", "18", "20", "22", "24"],
                datasets: [
                    {
                        label: "Luminosité",
                        fill: false,
                        lineTension: 0.1,
                        backgroundColor: "rgba(26,223,68,0.4)",
                        borderColor: "rgba(26,223,68,1)",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: "rgba(26,223,68,1)",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "rgba(26,223,68,1)",
                        pointHoverBorderColor: "rgba(220,220,220,1)",
                        pointHoverBorderWidth: 2,
                        pointRadius: 1,
                        pointHitRadius: 10,
                        data: [10,11,20, 59, 80, 81, 321, 450, 380, 128, 7, 9],
                        spanGaps: false,
                    }
                ]
            },	
			options: {
				  legend: {
        display: false
    },
				animation: {
					 duration: 2000,
					 easing: 'easeOutQuart'
				}
			}
 
        });
 
    }
 
 
}