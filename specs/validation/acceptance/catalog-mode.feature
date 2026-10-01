Feature: Catalog mode

  @story-1
  Rule: Service2 starts in full mode, serving its fixed catalog of 10 scored records

    Scenario: Service2's initial catalog
      Given Service2 has just started and has not been switched to any mode
      When its catalog is requested
      Then it serves all 10 scored records, including "alpha-record" with score 41 and "kappa-record" with score 8

  @story-1
  Rule: Service2's internal operations endpoint can switch it between full and empty mode

    Scenario: Switching to empty mode
      Given Service2 is serving its full catalog
      When the internal operations endpoint switches Service2 to empty mode
      Then Service2's catalog has no records

    Scenario: Switching back to full mode
      Given Service2 is serving an empty catalog
      When the internal operations endpoint switches Service2 to full mode
      Then Service2 again serves all 10 of its scored records
