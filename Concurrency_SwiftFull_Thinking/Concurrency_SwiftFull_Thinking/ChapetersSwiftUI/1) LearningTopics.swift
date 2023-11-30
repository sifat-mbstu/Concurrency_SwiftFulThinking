//
//  LearningTopics.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 11/28/23.
//

import SwiftUI

struct LearningTopicsView: View {
    @Environment(\.dismiss) var dismiss
     var simpleText = """
    this playlist is going to be
    
    everything that you need to know about

    swift concurrency for those who don't

    know swift concurrency was recently

    added to the swift language so before

    this there were predominantly two main

    ways of writing asynchronous code in

    swift we used escaping closures and we

    used combine if you don't know either of

    those i would recommend checking those

    out first before learning swift

    concurrency and i covered both of those

    on the continued learning playlist on my

    channel

    go check those out if you're interested

    and then come on back to this one if you

    do have a basic understanding of how we

    used to write asynchronous code in swift

    it'll definitely help you learn here how

    we're going to write it now now

    admittedly when a swift concurrency

    first came out

    i was not sure if i was going to be

    really using it that much if you follow

    this channel you know i love to use the

    combine framework and combine is awesome

    and powerful in itself

    but after using swift concurrency for a

    couple months now i can

    tell you with almost 100 confidence that

    this is by far the best way of writing

    asynchronous code in swift

    if you are a swift developer you need to

    be writing asynchronous code using async

    await as soon as possible using async 08

    and actors is not only going to make you

    better as a developer but it's going to

    make your app significantly better and

    more performant because

    as you guys are going to see there's a

    ton of stuff that's just built in to the

    language and to the compiler that will

    require us basically to code in a very

    specific way and by writing our code in

    this way

    we end up writing better code more

    readable code more efficient code and

    safer code

    as you're going to see there's a lot of

    kind of safety nets built into the

    compiler to ensure that we are writing

    our code correctly the first couple

    times that we're going to hit errors it

    seems like annoying that the compiler is

    going to throw this at us but really as

    we're going to learn this stuff is going

    to help us in the long run it's going to

    make sure we are writing our code

    correctly

    and efficiently

    now this playlist is going to be just

    like all the other bootcamp playlists on

    my channel it is uh progressive each

    video is going to tackle a different

    topic topics are going to build on each

    other

    more than other playlists this playlist

    should definitely be watched in order

    because we're going to start with the

    simple stuff and we're going to work our

    way up to the harder stuff

    in order to understand swift concurrency

    we also need a deep understanding of the

    swift language and so there are a couple

    videos in this playlist that are not

    technically new to swift concurrency

    but they're tackling things that are in

    the swift language that i have not

    covered on this channel that we do need

    to know

    in order to really dive into swift

    concurrency so for example

    one of the big things in swift

    concurrency is the use of actors

    but it's really hard to understand what

    an actor is if you don't understand the

    difference between

    a class and an actor and it's really

    hard to understand

    that difference if you don't first

    understand the difference between a

    struct and a class and so some of these

    things that we're just gonna dive into

    in this playlist i really hope will

    ultimately help you gain a better

    understanding of not just swift

    concurrency but the swift language

    itself

    and with that said i will point out that

    the first two or three videos are a

    little bit slow in this playlist because

    we got to cover some basics first but i

    promise you that if you stick with it

    this playlist ramps up it goes super

    easy just super hard in about five

    videos
    """
    var body: some View {
        VStack {
            ScrollView {
                Button("back") {
                    dismiss()
                }
                .background(.yellow)
                .position(x: 10, y: 10)
                .frame(width: 100, height: 44, alignment: .center)
                
                Text(simpleText)
                    .frame(width: (UIScreen.main.bounds.width - 50.0), alignment: .leading)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }
        }
        
    }
}

#Preview {
    LearningTopicsView()
}
