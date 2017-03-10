import { Component } from 'react';

export class Header extends Component {

  constructor(props) {
    super(props);
    this.headerName = '';
  }
  setHeaderName(hName) {
    this.headerName = hName;
  }
  getHeaderName() {
    return this.headerName;
  }
}
