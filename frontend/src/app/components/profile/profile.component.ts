import { Component } from '@angular/core';
import { ProfileService } from 'src/app/profile.service';
import { Profile } from './profile';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent {

  constructor(private profileService: ProfileService) { }
  ngOnInit(): void {
    let id = localStorage.getItem("user_id");
    this.profileService.getProfile(Number(id)).subscribe((response) => {
      this.profileService.setProfileInfo(response);
    });
      // this.profileService.setProfileInfo(new Profile(1,"Aliaa","Ibrahem","aliaa.ebrahem@gmail.com","1234"));

  }

}
