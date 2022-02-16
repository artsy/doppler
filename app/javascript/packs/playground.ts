import React from "react"
import ReactDOM from "react-dom"
import { RedocStandalone } from 'redoc';


$(() => {
  const root = document.getElementById("playground-root")
  const props = JSON.parse(root.dataset.props)

  if (root) {
    ReactDOM.render(
      <RedocStandalone specUrl={props.api_docs_url} />,
      root
    )
  }
})