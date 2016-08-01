module UsersHelper
    # Allow Showing of the Users Gravatar
    # As noted in the Gravatar documentation, Gravatar URLs are based on an MD5 hash of the user’s email address
    def gravatar_for(user, size: 80)
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end
end
