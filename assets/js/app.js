import React                    from 'react';
import { createStore } from 'redux';
import ReactDOM                 from 'react-dom';
import Root                     from './containers/root';
import { BrowserRouter } from 'react-router-dom'
import reducers                 from './reducers';

let store  = createStore(reducers);

const target = document.getElementById('main_wrapper');
const node = (
  <BrowserRouter>
    <div>
      <Root store={store} />;
    </div>
  </BrowserRouter>
)

ReactDOM.render(node, target);
