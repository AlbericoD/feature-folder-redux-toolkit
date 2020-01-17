#!/bin/sh
# Gerador de estrutura para projetos em react + redux
echo "Gerando estrutura...."
component="import React from 'react';\n\n
export default () => <>Component</>;"
root_component="import React from 'react';\n
import ExampleFeature from 'features/example-feature/example-new-feature';\n
export default () => <>App Component <ExampleFeature /></>;"
reducer_content="import { createSlice } from '@reduxjs/toolkit;'\n
let nextTodoId = 0;\n
const todosSlice = createSlice({
  name: 'todos',
  initialState: [],
  reducers: {
    addTodo: {
      reducer(state, action) {
        const { id, text } = action.payload
        state.push({ id, text, completed: false })
      },
      prepare(text) {
        return { payload: { text, id: nextTodoId++ } }
      }
    },
    toggleTodo(state, action) {
      const todo = state.find(todo => todo.id === action.payload)
      if (todo) {
        todo.completed = !todo.completed
      }
    }
  }
})\n
export const { addTodo, toggleTodo } = todosSlice.actions
\nexport default todosSlice.reducer"

create_features_folder() {
  echo "criando feature folder..."
  mkdir features && cd features
  echo "complex components (with reducer, with logic and etc)" >>ABOUT.md
  mkdir example-feature && cd example-feature
  echo $component >>example-new-feature.js
  cd ../../
}
create_reducers_folder() {
  echo "criando reducer folder..."
  mkdir reducer && cd reducer
  echo "redux toolkit structure" >>ABOUT.md
  echo $reducer_content >>index.js
  cd ../
}
create_components_folder() {
  echo "criando components folder..."
  mkdir components && cd components
  echo $component >>commom-component.js
  echo "components that are reused in multiple places" >>ABOUT.md
  cd ../
}
create_utils_folder() {
  echo "criando utils folder..."
  mkdir utils && cd utils
  echo "various string utility functions" >>ABOUT.md
  echo "export const sum = (x , y)=> x + y;" >>sum.js
  cd ../
}
create_api_folder() {
  echo "criando api folder..."
  mkdir api && cd api
  echo "fetching functions and data" >>ABOUT.md
  echo " export const myApiResource = fetch('my-api-url/resource')
      .then(response => response.json());" >>my-api-resource.js
  cd ../
}
create_app_folder() {
  echo "criando api folder..."
  mkdir app && cd app
  echo "main components" >>ABOUT.md
  echo $root_component >>App.js
  cd ../
}

rm -rf src/
mkdir src
cd src
create_features_folder
create_components_folder
create_reducers_folder
create_api_folder
create_utils_folder
