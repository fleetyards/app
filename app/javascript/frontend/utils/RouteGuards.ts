import fleetsCollection from 'frontend/api/collections/Fleets'
import modelsCollection from 'frontend/api/collections/Models'
import { Route, NavigationGuardNext } from 'vue-router'

export const fleetRouteGuard = async function fleetRouteGuard(
  to: Route,
  _from: Route,
  next: NavigationGuardNext,
) {
  const fleet = await fleetsCollection.findBySlug(to.params.slug)

  if (!fleet || !fleet.myFleet) {
    next({ name: '404' })
  } else {
    next()
  }
}

export const publicFleetRouteGuard = async function publicFleetRouteGuard(
  to: Route,
  _from: Route,
  next: NavigationGuardNext,
) {
  const fleet = await fleetsCollection.findBySlug(to.params.slug)

  if (!fleet) {
    next({ name: '404' })
  } else {
    next()
  }
}

export const modelRouteGuard = async function modelRouteGuard(
  to: Route,
  _from: Route,
  next: NavigationGuardNext,
) {
  const model = await modelsCollection.findBySlug(to.params.slug)

  if (!model) {
    next({ name: '404' })
  } else {
    next()
  }
}