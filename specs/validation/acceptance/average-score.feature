Feature: Average score

  @story-1
  Rule: Service1 returns the whole-number average score of Service2's current catalog

    Scenario: Averaging the full catalog
      Given Service2 is serving its full catalog of scored records
      When Nora the API consumer requests the average score from Service1
      Then she receives an average of 35

  @story-2
  Rule: A request to a path Service1 does not serve returns a structured error body

    @negative
    Scenario: An unsupported path is requested
      Given Service1 is running
      When Nora the API consumer requests a path Service1 does not serve
      Then she receives a 404 response with a structured error body
