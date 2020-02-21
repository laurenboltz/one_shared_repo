include: "events.view.lkml"

view: events_extended {
  extends: [events]

dimension: test_id {}


measure: count_events {
  type: count
  drill_fields: [event_set*]
  }
}
