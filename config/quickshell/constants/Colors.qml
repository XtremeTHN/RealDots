pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

import "../services"

Singleton {
  id: root

  property color background
  property color error
  property color error_container
  property color inverse_on_surface
  property color inverse_primary
  property color inverse_surface
  property color on_background
  property color on_error
  property color on_error_container
  property color on_primary
  property color on_primary_container
  property color on_primary_fixed
  property color on_primary_fixed_variant
  property color on_secondary
  property color on_secondary_container
  property color on_secondary_fixed
  property color on_secondary_fixed_variant
  property color on_surface
  property color on_surface_variant
  property color on_tertiary
  property color on_tertiary_container
  property color on_tertiary_fixed
  property color on_tertiary_fixed_variant
  property color outline
  property color outline_variant
  property color primary
  property color primary_container
  property color primary_fixed
  property color primary_fixed_dim
  property color scrim
  property color secondary
  property color secondary_container
  property color secondary_fixed
  property color secondary_fixed_dim
  property color shadow
  property color source_color
  property color surface
  property color surface_bright
  property color surface_container
  property color surface_container_high
  property color surface_container_highest
  property color surface_container_low
  property color surface_container_lowest
  property color surface_dim
  property color surface_tint
  property color surface_variant
  property color tertiary
  property color tertiary_container
  property color tertiary_fixed
  property color tertiary_fixed_dim


  Behavior on background  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on error  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on error_container  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on inverse_on_surface  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on inverse_primary  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on inverse_surface  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_background  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_error  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_error_container  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_primary  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_primary_container  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_primary_fixed  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_primary_fixed_variant  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_secondary  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_secondary_container  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_secondary_fixed  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_secondary_fixed_variant  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_surface  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_surface_variant  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_tertiary  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_tertiary_container  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_tertiary_fixed  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on on_tertiary_fixed_variant  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on outline  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on outline_variant  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on primary  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on primary_container  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on primary_fixed  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on primary_fixed_dim  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on scrim  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on secondary  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on secondary_container  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on secondary_fixed  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on secondary_fixed_dim  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on shadow  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on source_color  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on surface  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on surface_bright  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on surface_container  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on surface_container_high  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on surface_container_highest  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on surface_container_low  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on surface_container_lowest  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on surface_dim  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on surface_tint  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on surface_variant  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on tertiary  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on tertiary_container  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on tertiary_fixed  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}
  Behavior on tertiary_fixed_dim  { ColorAnimation { duration: 300; easing.type: Easing.OutCubic }}

  FileView {
    path: Utils.joinPath(Quickshell.shellDir, "colors.json")
    watchChanges: true
    onFileChanged: reload()

    onLoaded: {
      var data = JSON.parse(text())

      for (let x in data) {
        root[x] = data[x]
      }
    }
  }
}
