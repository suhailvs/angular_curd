import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {first} from "rxjs/operators";

import {UserService} from "../user.service";
import {User} from "../user.model";


@Component({
  selector: 'app-edit-user',
  templateUrl: './edit-user.component.html',
  styleUrls: ['./edit-user.component.css']
})
export class EditUserComponent implements OnInit {
  loading = true;
  user: User;
  editForm: FormGroup;
  constructor(
    private formBuilder: FormBuilder,
    private router: Router, 
    private route: ActivatedRoute,
    private userService: UserService
  ) { }

  ngOnInit() {
  	//https://blog.thoughtram.io/angular/2016/10/10/resolving-route-data-in-angular-2.html
  	let userId = this.route.snapshot.paramMap.get('id');
    
    this.editForm = this.formBuilder.group({
      id: [],
      email: ['', Validators.required],
      firstName: ['', Validators.required],
      lastName: ['', Validators.required]
    });
    this.userService.getUserById(+userId)
      .subscribe( data => {
        this.editForm.setValue(data);        
        this.loading=false;
      });
  }

  onSubmit() {
    this.loading = true;
    this.userService.updateUser(this.editForm.value)
      .pipe(first())
      .subscribe(
        data => {
          this.router.navigate(['list-user']);
          this.loading = false;
        },
        error => {
          alert(error);
          this.loading = false;
        });
  }

}
