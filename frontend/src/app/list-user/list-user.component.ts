import { Component, OnInit } from '@angular/core';
import {Router} from "@angular/router";
import {UserService} from "../user.service";
import {User} from "../user.model";

@Component({
  selector: 'app-list-user',
  templateUrl: './list-user.component.html',
  styleUrls: ['./list-user.component.css']
})
export class ListUserComponent implements OnInit {
  loading = true;
  users: User[];

  constructor(
    private router: Router, 
    private userService: UserService
  ) { }

  ngOnInit() {
    this.userService.getUsers()
      .subscribe( data => {
        this.users = data;
        this.loading = false;
      });
  }

  deleteUser(user: User): void {
    this.loading = true;
    this.userService.deleteUser(user.id)
      .subscribe( data => {
        this.users = this.users.filter(u => u !== user);
        this.loading = false;
      })
  };

  addUser(): void {
    this.router.navigate(['add-user']);
  };
}
