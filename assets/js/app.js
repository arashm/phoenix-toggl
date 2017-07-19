import React             from 'react';
import {
  createStore,
  applyMiddleware
}                        from 'redux';
import ReactDOM          from 'react-dom';
import { BrowserRouter } from 'react-router-dom'
import {
  ConnectedRouter,
  routerMiddleware
}                        from 'react-router-redux'
import thunk             from 'redux-thunk';
import reducers          from './reducers';
import createHistory     from 'history/createBrowserHistory'
import Root              from './containers/root';
import { Provider }      from 'react-redux';

const history = createHistory()
const middleware = [routerMiddleware(history), thunk]

const store = createStore(
  reducers,
  applyMiddleware(...middleware)
)

const target = document.getElementById('main_wrapper');
const node = (
  <Provider store={store}>
    <ConnectedRouter history={history}>
      <Root store={store} />
    </ConnectedRouter>
  </Provider>
);

ReactDOM.render(node, target);
