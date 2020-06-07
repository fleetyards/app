import { get } from 'frontend/lib/ApiClient'

export class UserCollection {
  record: User | null = null

  async current(): Promise<User | null> {
    const response = await get('users/current')

    if (!response.error) {
      this.record = response.data
    }

    return this.record
  }
}

export default new UserCollection()