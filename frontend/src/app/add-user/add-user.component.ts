import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {UserService} from "../user.service";
import {first} from "rxjs/operators";
import {Router} from "@angular/router";

@Component({
  selector: 'app-add-user',
  templateUrl: './add-user.component.html',
  styleUrls: ['./add-user.component.css']
})
export class AddUserComponent implements OnInit {
  submitted = false;
  loading = false;
  addForm: FormGroup;
  addErrors: string;

  constructor(private formBuilder: FormBuilder,private router: Router, private userService: UserService) { }

  ngOnInit() {

    this.addForm = this.formBuilder.group({
      id: [],
      email: ['', Validators.required],
      firstName: ['', [Validators.required, Validators.minLength(6)]],
      lastName: ['', Validators.required]
    });

  }

  get f() { return this.addForm.controls; }

  onSubmit() {
    this.submitted = true;
    if (this.addForm.invalid) return;
    this.loading = true;
  	this.userService.createUser(this.addForm.value)
    .subscribe( data => {
      this.router.navigate(['list-user']);
    },
    error => {
      this.addErrors = error;
      this.loading = false;
    });
  }

}