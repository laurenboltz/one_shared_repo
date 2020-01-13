include: "events.view.lkml"

view: events_extended {
  extends: [events]

dimension: test_id {}
}
