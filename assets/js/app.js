import React                    from 'react';
import { createStore, applyMiddleware } from 'redux';
import ReactDOM                 from 'react-dom';
import Root                     from './containers/root';
import { BrowserRouter }        from 'react-router-dom'
import thunk                    from 'redux-thunk';
import reducers                 from './reducers';

let store  = createStore(reducers, applyMiddleware(thunk));

const target = document.getElementById('main_wrapper');
const node = (
  <BrowserRouter>
    <div>
      <Root store={store} />;
    </div>
  </BrowserRouter>
)

ReactDOM.render(node, target);
