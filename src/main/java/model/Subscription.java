package model;

public class Subscription {
    private User subscriber;
    private User channelOwner;

    public Subscription() {
    }

    public Subscription(User subscriber, User channelOwner) {
        this.subscriber = subscriber;
        this.channelOwner = channelOwner;
    }

    public User getSubscriber() {
        return subscriber;
    }

    public void setSubscriber(User subscriber) {
        this.subscriber = subscriber;
    }

    public User getChannelOwner() {
        return channelOwner;
    }

    public void setChannelOwner(User channelOwner) {
        this.channelOwner = channelOwner;
    }

    @Override
    public String toString() {
        return "Subscription{" + "subscriber=" + subscriber + ", channelOwner=" + channelOwner + '}';
    }
}
