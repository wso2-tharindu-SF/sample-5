# sample-5 — PRD

## Problem Statement

Teams that need a quick summary statistic over a scored catalog of records
today have to fetch every record themselves and compute the aggregate by hand,
even when the catalog is small and fixed. There is no single endpoint that
hands back the summary directly, and no reliable way to test how a consuming
system behaves when the underlying catalog is temporarily empty.

## Solution

Two backend services work together to serve a single derived statistic over a
scored catalog. Service2 holds the catalog of scored records and can be
switched, through an internal-only control, between serving its full fixed
catalog and serving no records at all. Service1 asks Service2 for the current
catalog and returns the average score as a whole number, so any external
consumer gets the aggregate directly rather than recomputing it.

## Actors

- **External API Consumer** — any external application or system that calls
Service1's average-score endpoint to retrieve the current average. Access is
open — no sign-in or credential is required *(Product Decision, answered)*.

Service2's catalog-mode switch is an internal operational control, not a
product-facing capability, and no product actor invokes it — see Product
Decisions.

## User Stories

1. As an External API Consumer, I want to call Service1 and receive the
 average score of Service2's current catalog, so that I get the aggregate
 directly instead of fetching every record and computing it myself.
2. As an External API Consumer, I want a request to a path Service1 does not
 serve to return a structured 404 body, so that I can distinguish "no such
 endpoint" from other failures programmatically.

## Product Decisions

- **Actor and access model**: Service1's average-score endpoint is called by
an External API Consumer and is open — no authentication or access control
is required to reach it *(answered by the user)*.
- **Fixed catalog data**: Service2's full mode serves exactly this catalog,
reproduced verbatim from the idea and carried into the design's seed data:
- **Catalog modes**: Service2 starts in full mode and can be switched to empty
mode (a catalog with no records) through an internal operations endpoint.
That endpoint is never reachable by any product actor — it exists solely so
the system's behavior against an empty catalog can be exercised.
- **Uniform computation**: Service1 computes the average score — the sum of
every record's score divided by the record count, discarding any remainder —
identically for whichever catalog Service2 currently serves. There is no
separate path or separate result for any particular catalog, and with the
full catalog the result is 35.
- **Operability logging**: Both Service1 and Service2 log how many records
they handled per request, to support operational troubleshooting.
- **No external, third-party service dependency**: Service2 is an internal
component of this same project, not a Registered External resource or a
third-party integration — nothing here is sourced from outside the
organization.

## Out of Scope

- What Service1 returns, computes, or responds when Service2's catalog is
empty — no value, default, or error response for that case is part of this
product's requirements.
- Any alternative response shape, documented empty-catalog variant, or
optional field on either service's OpenAPI contract.
- Any documented 4xx or 5xx response on Service1's average-score endpoint,
regardless of cause — that endpoint documents exactly one, successful,
response. (The structured 404 in User Story 2 applies only to paths Service1
does not serve, not to this endpoint.)
- Authentication, API keys, or any other access control in front of Service1's
endpoint.
- Any human or UI access to Service2's operations endpoint — it is
internal-only by design.

## Open Questions

None at this time — the idea fully specifies the product's behavior and the
interview settled the remaining product-altitude decisions (actor and access
model).