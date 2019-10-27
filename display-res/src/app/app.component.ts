import {Component, OnInit} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs';
import * as _ from 'lodash';
import {Howl, Howler} from 'howler';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit {
   result: any;
  partite_andata: any = [];
  partite_ritorno: any = [];
  // private girone_contiene_squadra: any = [];
  snc: any = [];
  gironi: any = [];
  lodash = _;

  sound = new Howl({
    src: ['./assets/champions.mp3']
  });

  constructor(private http: HttpClient) {
    this.getJSON().subscribe(data => {

      this.result = data;
      // console.log(data);

      for (const entry of this.result) {

        if (entry.name === 'girone_contiene_squadra') {


          var group = _.find(this.gironi, {girone: entry.args[0].name});

          if (!group) {
            // console.log("qua")
            var new_girone = {
              girone: entry.args[0].name,
              squadre: [entry.args[1].name]
            };
            this.gironi.push(new_girone);
          } else {

            _.remove(this.gironi, {
              girone: entry.args[0].name
            });

            this.gironi.push({
              girone: group.girone,
              squadre: [...group.squadre, entry.args[1].name]
            });
          }


        } else if (entry.name === 'snc') {

          this.snc.push({
            squadra: entry.args[0].name,
            nazione: entry.args[1].name,
            citta: entry.args[2].name
          });

        } else if (entry.name === 'partita_andata') {

          var index = _.findIndex(this.partite_andata, {id: entry.args[3].value});
          if (index === -1) {
            this.partite_andata.push({
              id: entry.args[3].value,
              partite: [
                {key: 'gruppo_A', value: []},
                {key: 'gruppo_B', value: []},
                {key: 'gruppo_C', value: []},
                {key: 'gruppo_D', value: []},
                {key: 'gruppo_E', value: []},
                {key: 'gruppo_F', value: []},
                {key: 'gruppo_G', value: []},
                {key: 'gruppo_H', value: []}]
            });
            index = _.findIndex(this.partite_andata, {id: entry.args[3].value});
          }
          this.partite_andata[index] = {
            ...this.partite_andata[index],
            partite: [
              ..._.map(this.partite_andata[index].partite, (v) => {
                if (v.key === entry.args[0].name) {
                  return {
                    key: v.key,
                    value: [...v.value, entry.args]
                  };
                } else {
                  return v;
                }
              })
            ]
          };

        } else if (entry.name === 'partita_ritorno') {

          var index = _.findIndex(this.partite_ritorno, {id: entry.args[3].value});
          if (index === -1) {
            this.partite_ritorno.push({
              id: entry.args[3].value,
              partite: [
                {key: 'gruppo_A', value: []},
                {key: 'gruppo_B', value: []},
                {key: 'gruppo_C', value: []},
                {key: 'gruppo_D', value: []},
                {key: 'gruppo_E', value: []},
                {key: 'gruppo_F', value: []},
                {key: 'gruppo_G', value: []},
                {key: 'gruppo_H', value: []}]
            });
            index = _.findIndex(this.partite_ritorno, {id: entry.args[3].value});
          }
          this.partite_ritorno[index] = {
            ...this.partite_ritorno[index],
            partite: [
              ..._.map(this.partite_ritorno[index].partite, (v) => {
                if (v.key === entry.args[0].name) {
                  return {
                    key: v.key,
                    value: [...v.value, entry.args]
                  };
                } else {
                  return v;
                }
              })
            ]
          };

        }


      }

      this.preProcessingGironi();
      this.preProcessingPartite();


    });
  }

  public getJSON(): Observable<any> {
    return this.http.get('./assets/result.json');
  }

  ngOnInit() {
  }

  preProcessingGironi() {
    this.gironi = _.map(this.gironi, (v) => {
      v.girone = _.upperCase(v.girone.replace('_', ' '));
      return v;
    });

    // console.log(this.gironi);

    // Ordino i gironi da A ad H
    this.gironi = _.sortBy(this.gironi, ['girone']);

  }

  preProcessingPartite() {
    console.log(this.partite_andata);

    // console.log(_.chain(this.partite_andata)
    //   .map(x => x.partite)
    //   .map(x => x[_][0].name)
    //   .value());


  }


  music() {

    if (this.sound.playing()) {
      this.sound.pause();
    } else {
      this.sound.play();
      Howler.volume(0.5);
    }

  }


}
